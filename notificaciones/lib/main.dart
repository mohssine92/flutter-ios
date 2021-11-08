import 'package:flutter/material.dart';

import 'package:notificaciones/screens/message_screen.dart';
import 'package:notificaciones/services/push_notificacionesservice.dart';

import 'package:notificaciones/screens/home_screen.dart';

void main() async {
  // ver video 265 - sobre el err que resuelva esta linea  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService
      .initializeApp(); // en resumen la linea de arriba hace cuando se ejecuta esta linea y el context estara listo

  runApp(MyApp());
}

// la idea tener informacion de notificaciones en nivel alto de a app - asi siempre user lo va a tener - en contrario si lo hacemos dentro de un widget puede que user no llega a entrar a este wiget
// y nunca sera notificado
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ref para poder lanzar navigacion y snack desde duera del scope de meterial app s
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    // Context! - static - este contexto no esta en el scop en el contexto de material app
    // cloud Mesaging - opciones adicionales - mandar map - para construir un scafold de oferta publicidad - mandar type : y reccionar dependiendo del tipo como hace redux
    PushNotificationService.messagesStream.listen((message) {
      print('MyApp: $message');

      navigatorKey.currentState?.pushNamed('message', arguments: message);

      final snackBar =
          SnackBar(content: Text(message), backgroundColor: Colors.redAccent);
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey, // Navegar
      scaffoldMessengerKey: messengerKey, // Snacks
      routes: {
        'home': (_) => HomeScreen(),
        'message': (_) => MessageScreen(),
      },
    );
  }
}
