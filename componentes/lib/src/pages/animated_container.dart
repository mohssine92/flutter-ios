import 'package:flutter/material.dart';

import 'dart:math';

// sattefullwidget
// statefull porque las props se cambian no son constantes
class AnimatedContainerPage extends StatefulWidget {
  const AnimatedContainerPage({Key? key}) : super(key: key);

  @override // f creacion de estado
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}

// su manejador de estado
class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  // estado

  // props en el state . se mutuan - esto es el stete de satetfullwidget
  double _width = 50.0;
  double _height = 50.0;
  Color _color = Colors.pink;

  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8.0);

  @override
  Widget build(BuildContext context) {
    // creacion de vista
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Container'),
      ),
      body: Center(
          child: AnimatedContainer(
        // habia container por lo hace sin animacion
        duration: const Duration(
            seconds:
                1), // tiempo va a tardar de cambia de estado anterior a nuevo estado
        curve: Curves.fastOutSlowIn, // 77 docs curva de animacion
        width: _width,
        height: _height,
        decoration: BoxDecoration(
            borderRadius: _borderRadius, // lo que define arriba
            color: _color),
      )),
      floatingActionButton: FloatingActionButton(
        //al scaffold()
        child: const Icon(Icons.play_arrow),
        onPressed: _cambiarForma,
      ),
    );
  }

  void _cambiarForma() {
    final random = Random();

    setState(() {
      // cambiar estae de props definidas en el state de este container widget ..

      _width = random.nextInt(300).toDouble(); // 300 max number rundom
      _height = random.nextInt(300).toDouble();
      _color = Color.fromRGBO(
          random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);

      _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
    }); // setStaet lo que hace cambia estado y se manda redibujar widget
  }
}

// aqui vemos concepto de implementacionde una clasee contiene prop cambian de state
//// no tenemos obligacion de cambiar state  de todas props - siempre segun nuestro interes
///
