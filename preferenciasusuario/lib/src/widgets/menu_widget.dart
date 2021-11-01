// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:preferenciasusuario/src/pages/home_page.dart';
import 'package:preferenciasusuario/src/pages/settings_page.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // icon de haburguesa menu lateral
      // list view para poder hacer scroll arriba y abajo por si acaso hay mas opciones
      child: ListView(
        padding: EdgeInsets.zero, // empieza de aariba sin margin
        children: <Widget>[
          DrawerHeader(
            // child muestra emcima del fondo - no quiero nostrar nada dejo container vacio
            child: Container(),
            // es fondo de DrawerHeader
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/menu-img.jpg'),
                    fit: BoxFit.cover // expanda todo ancho posible
                    )),
          ),
          // ipciones del menu
          ListTile(
            leading: Icon(Icons.pages, color: Colors.blue),
            title: Text('Home'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, HomePage.routeName),
          ),

          ListTile(
            leading: Icon(Icons.party_mode, color: Colors.blue),
            title: Text('Party Mode'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.people, color: Colors.blue),
            title: Text('People'),
            onTap: () {},
          ),

          ListTile(
              leading: Icon(Icons.settings, color: Colors.blue),
              title: Text('Settings'),
              onTap: () {
                //Navigator.pop(context); // cerra menu  pushNamed : permite regresar
                Navigator.pushReplacementNamed(
                    // remplza pagina y la pone como pagina principal
                    context,
                    SettingsPage
                        .routeName); // cierra menu y telleva a una pagina donde no puedees regresar
                //esto nos util cuando alguien hace login y no queremos que no se regresa a la pantalla anterior
              }),
        ],
      ),
    );
  }
}

// centralizar de nuestro menu lateral com widget o no como una funcion , porque widget consta de build donde tenemos context asi no tenomos que pasar para tema de navigacion
// tenerlo centralizado es  facil de usar en cualquier widget page requiero el menu
