// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
      ),
      body: ListView(
        // scroll
        padding: const EdgeInsets.all(
            10.0), // p anterior all a todas direcciones  71
        children: <Widget>[
          _cardTipo1(),
          const SizedBox(height: 30.0), // poner espacio entre card y card
          // para abribar lsit view copio y pego varias veces esto
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}

Widget _cardTipo1() {
  return Card(
    // 71
    elevation: 10.0, // como se proyecta la sombra
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            20.0)), // ciuadrados cicrculas hay varios docs
    child: Column(
      // ordenar mas elemento de manera vertical
      children: <Widget>[
        const ListTile(
          // scrol col numer 1
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Soy el titulo de esta tarjeta'),
          subtitle: Text(
              'Aquí estamos con la descripción de la tajera que quiero que ustedes vean para tener una idea de lo que quiero mostrarles'),
        ),
        Row(
          // col number 2
          mainAxisAlignment: MainAxisAlignment.end, //al children
          children: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {},
            ),
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {},
            )
          ],
        )
      ],
    ),
  );
}

Widget _cardTipo2() {
  // usamos container parece card - nos ayuda mucho tener control de lo que hacemos
  // ignore: avoid_unnecessary_containers
  final card = Container(
    // poner todo este objeto esta tarjeta en una variable
    child: Column(
      children: <Widget>[
        FadeInImage(
          // loadin de los images
          image: NetworkImage(
              'https://static.photocdn.pt/images/articles/2017_1/iStock-545347988.jpg'), // img a cargar
          placeholder: AssetImage(
              'assets/jar-loading.gif'), //loading mientras la carga de img
          fadeInDuration: Duration(milliseconds: 200),
          height: 300.0,
          fit: BoxFit
              .cover, // adptar imagen depende del contenedor al que le estamos asignando
        ),
        // ignore: avoid_unnecessary_containers
        Container(
            padding: const EdgeInsets.all(10.0),
            child: const Text('No tengo idea de que poner'))
      ],
    ),
  );

  return Container(
    // contenedor al que debe adaptarse la img
    // 74, == div html , no cambia nada ancho alto es de su contenido , pero tiene varias props interesantes a aplicar
    decoration: BoxDecoration(
        // para decora el contenedor
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white, // color container
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(
                  2.0, 10.0) // coordenadas x,y mover la sombra negativo tambien
              )
        ]),
    //clipBehavior: Clip.antiAlias,
    child: ClipRRect(
      // permite cortar cualquier elemento sobre sale del container
      borderRadius: BorderRadius.circular(20.0),
      child: card, // final
    ),
  );
}

// objetivo de este widget es tener list view de dos tipos de card ,
