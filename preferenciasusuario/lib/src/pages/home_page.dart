// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:preferenciasusuario/src/share_prefs/preferencias_usuario.dart';

import 'package:preferenciasusuario/src/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {
  // definir nombre pagina para uso en router
  static const String routeName = 'home';

  // sabemos en main se instancia este singlton por primer vez y se ejecuto la tarea asyncrona de inicializar preferencia .
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = HomePage
        .routeName; // setter pagina actual a preferencias - memoria cenral

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferencias de Usuario'),
        backgroundColor: (prefs.colorSecundario) // depende del boolean
            ? Colors.teal
            : Colors.blue,
      ),
      // menu lateral - es un widget y no es funcion asi no occupo mandar context .
      // ignore: prefer_const_constructors
      drawer: MenuWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Color secundario: ${prefs.colorSecundario} '),
          Divider(),
          Text('Género: ${prefs.genero} '),
          Divider(),
          Text('Nombre usuario:  ${prefs.nombreUsuario}'),
          // ignore: prefer_const_constructors
          Divider()
        ],
      ),
    );
  }
}
