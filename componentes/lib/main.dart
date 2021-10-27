import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:componentes/src/routes/routes.dart';
import 'package:componentes/src/pages/alert_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        // configuracion de idioma  fecha calendar desplegado  video 81
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // English - variables soportadas
        Locale('fr', 'FR'),
      ],
      initialRoute: '/',
      routes: getApplicationRoutes(), //69
      onGenerateRoute: (RouteSettings settings) {
        // cuando la ruta llamada no esta definida en getAppRoutes se dispara onGenerateRoutes
        // 70
        // seejecuta solamente cuando la ruta llmada no esta definida en la mapa de routes

        print(
            'Ruta llamda: ${settings.name}'); // settings.name  ruta dinamica clickeada

        //aqui puede tomar decision dependiendo de la ruta llamada hacer validacion y realizar cualquier tipo de accion mandar a algun pagina en particular

        return MaterialPageRoute(
            // 70
            builder: (BuildContext context) => const AlertPage());
      },
    );
  }
}
