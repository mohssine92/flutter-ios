import 'package:flutter/material.dart';

import 'package:preferenciasusuario/src/pages/home_page.dart';
import 'package:preferenciasusuario/src/pages/settings_page.dart';
import 'package:preferenciasusuario/src/share_prefs/preferencias_usuario.dart';

void main() async {
  // evita err , cuando ejecutamos un preseso espera que se realize en main y que va impactar parte de nuestros arbol de widgets occupamos esta instruccion
  WidgetsFlutterBinding.ensureInitialized();

  final prefs =
      PreferenciasUsuario(); // singlton + es lugar superior y me permite ejecuatr tareas asyncronas del singlton .
  await prefs
      .initPrefs(); // cargar initializar prefrencias , recuerda es singlton asi , en cualquier lugar de la app solo intancio y obtengo esta misma instancia

  // recuerda que mi app no se redibuja hasta que mi singlton estara listo .
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // recuerda es un singlton regresa la misma instancia
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Preferencias',
      //initialRoute: HomePage.routeName,
      initialRoute: prefs.ultimaPagina, // la ultima pagina antes de cerrala app
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        SettingsPage.routeName: (BuildContext context) => SettingsPage(),
      },
    );
  }
}
