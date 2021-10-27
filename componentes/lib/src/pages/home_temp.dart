import 'package:flutter/material.dart';

// era home page temporal

class HomePageTemp extends StatelessWidget {
  final opciones = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinco'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Componentes Temporal'),
      ),
      body: ListView(
          // similar a Row y colomn para hacer scrol
          // children: _crearItems() // children permite hacer scrol en pantal : recibe coleccion de cualquier widger
          children: _crearItemsCorta()),
    );
  }

  List<Widget> _crearItems() {
    // regresa list de widget

    // ignore: deprecated_member_use
    List<Widget> lista = <Widget>[];

    for (String opt in opciones) {
      final tempWidget = ListTile(title: Text(opt));

      lista
        ..add(tempWidget) // push .. encadenar de pushes
        ..add(const Divider()); // linea dividora

    }

    return lista;
  }

  List<Widget> _crearItemsCorta() {
    return opciones.map((item) {
      // usar metodo map viene en todas las listas

      return Column(
        children: <Widget>[
          ListTile(
            title: Text(item + '!'),
            subtitle: const Text('Cualquier cosa'),
            leading: const Icon(Icons.account_balance_wallet), // widget inicio
            trailing: const Icon(Icons.keyboard_arrow_right), // widget final
            onTap: () {},
          ),
          Divider()
        ],
      );
    }).toList(); //  iterable que regresa lo convierto a una lista
  }
}

/// colomn tiene children
