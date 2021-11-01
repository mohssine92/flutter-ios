// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ScrollScreen extends StatelessWidget {
  ScrollScreen({Key? key}) : super(key: key);

  final boxDecoration = BoxDecoration(
      // image  tambien
      gradient: LinearGradient(
          begin: Alignment.topCenter, // donde empeiza graduado
          end: Alignment.bottomCenter, // dond termina graduado
          stops: [
        0.5,
        0.5
      ], // puntos quiebre nuestro gradiente
          // ignore: prefer_const_literals_to_create_immutables
          colors: [
        Color(0xff5EE8C5), // empieza
        Color(0xff30BAD6), // termina
      ]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: boxDecoration,
      child: PageView(
        // en un scafoll tenemos ascafolds scrolando : scrool de paginas
        physics: BouncingScrollPhysics(), //!!!
        scrollDirection: Axis
            .vertical, // comentada .. por default horizontal , requiere mminimo 2 pages
        children: [Page1(), Page2()],
      ),
    ));
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      // permite  colocar  widget encima de widget
      children: [
        // Background
        Background(),

        // Main Content - Column
        MainContent()
      ],
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff30BAD6),
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: Image(
          image: AssetImage('assets/scroll-1.png'),
        ));
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white);

    return SafeArea(
      // baja widget debajo del area del iphone de aariba
      bottom: false, // evita desplazamiento desde abajo para iphones ______
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Text('11°', style: textStyle),
          Text(
            'Miércoles',
            style: textStyle,
          ),
          Expanded(child: Container()), // space      color
          Icon(Icons.keyboard_arrow_down, size: 100, color: Colors.white)
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      color: Color(0xff30BAD6),
      child: Center(
        child: TextButton(
          onPressed: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text('Bienvenido',
                style: TextStyle(color: Colors.white, fontSize: 30)),
          ),
          style: TextButton.styleFrom(
              backgroundColor: Color(0xff0098FA), shape: StadiumBorder()),
        ),
      ),
    );
  }
}
