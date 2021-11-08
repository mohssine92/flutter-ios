import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  // trabajamos todo con metodo y prop staticas paraque no tener que crear instancia y tener que usar provider y  otro tipo de gestor de estado
  // asi me va  servir bastante sin  que tener tambien iniciar mi clase

  // obtener instancia del tipo - instalado en el project
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  // crear un stream para poder emitir valor y estar escuchando en el cotext .
  // lo que fluir en este caso 'string' pero puede ser mapa o lista  puede ser lo cualquier tipo de data .
  // broadcast(); por si casi poser subscribirse mas veces a esta emission
  static StreamController<String> _messageStream =
      new StreamController.broadcast();
  // exponer stream lo cual voy a suscribirme en mi main
  static Stream<String> get messagesStream => _messageStream.stream;

  // se dispara cuando la app esta encbackgroud del dispositivo y cuando abre la notificacion que reciba en barra superior
  static Future _backgroundHandler(RemoteMessage message) async {
    // TODO: manejo async por si acaso quiero grabar en db o algun lugar - preferencias etc
    // print('onBackground Handler ${message.messageId}');
    //print(message.data);
    //_messageStream.add(message.notification?.title ?? 'No data');

    print('_backgroundHandler');
    _messageStream.add(message.data['product'] ?? 'No data');
    print(message.data['product']);
  }

  // se dispara cuando la app abierta ycse emite notificacion del firebase mesaging
  static Future _onMessageHandler(RemoteMessage message) async {
    // print('onMessage Handler ${message.messageId}');
    //print(message.data);
    //  _messageStream.add(message.notification?.title ?? 'No data');
    //_messageStream.add(message.notification?.body ?? 'No data');
    // meter el tipo al stream paraque lo obtengan los escuhadores
    // data es objeto de opciones adicionales
    _messageStream.add(message.data['product'] ?? 'No data');
    print('-OnmessagHabdler');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print('onMessageOpenApp Handler ${message.messageId}');
    print('-OnmessageOpen');
    //print(message.data);
    //_messageStream.add(message.notification?.title ?? 'No data');
    //_messageStream.add(message.notification?.body ?? 'No data');

    // ? pude ser nul - ?? si no viene nada va ser 'no data '

    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future initializeApp() async {
    // Push Notifications

    // regresa propia instancia de firebase - inf de db , dbrealtime - storage etc..
    await Firebase.initializeApp();
    //await requestPermission();
    // token que necesito para poder inviar notificaciones es este dispositivo en particular

    // TODO: en este punto podemos hacer petiicon http y updatetoekn en db : decir que tal user tiene este token : este token solo de este emulador - indetificador para mandarle notificacion push
    token = await FirebaseMessaging.instance.getToken();

    print('Token: $token');

    // Handlers -  paso la ref funciones de mi class -
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(
        _onMessageHandler); // cuando la app esta abierta - lo que emite este listen calle en primer arg ver. es el mismo tipo del arg
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp); //

    // Local Notifications
  }

  // para el cierre del strem - pero nosotros en esta implementacion no la vamos a cerra - siempre estaremos escuchando notificaciones
  static closeStreams() {
    _messageStream.close();
  }
}

// reaccionar en app al recibir notificacion - debe tener control en absoluto de la informacion recibida fuera de esa clase
