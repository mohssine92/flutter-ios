import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final boxDecoration = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.8],
          colors: [Color(0xff2E305F), Color(0xff202333)]));

  Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // para colocar widger encima de otro  saco effecto de background
      children: [
        // Purple Gradinet background
        Container(decoration: boxDecoration),

        // Pink box
        Positioned(
            // posiciono la caja girada
            top: -100,
            left: -30,
            child: _PinkBox()),
      ],
    );
  }
}

class _PinkBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      // girar su child en cierto angulo
      angle: -pi / 5, // imprt math
      child: Container(
        width: 360,
        height: 360,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            gradient: LinearGradient(// equivale color
                colors: const [
              Color.fromRGBO(236, 98, 188, 1),
              Color.fromRGBO(241, 142, 172, 1),
            ])),
      ),
    );
  }
}
