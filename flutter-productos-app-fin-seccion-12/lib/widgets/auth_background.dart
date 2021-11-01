import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget { 
  
  final Widget child;

  const AuthBackground({
    Key? key, 
    required this.child // nuestro widget es capaz de recibir widget como arg
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.red,
        width: double.infinity, // este container occupa toto scafol del dispositivo 
        height: double.infinity, // este container occupa toto scafol del dispositivo 
        child: Stack( // es como column - pero coloca widgets unos encima de otros
          children: [

            _PurpleBox(), // primer widget

            _HeaderIcon(), // segundo ..

            this.child,

          ],
        ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea( // para dispositivos con noche como iphone 12
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only( top: 30 ), // bajalo en poco - deberia ver bien en dispositivos sin noche
        child: Icon( Icons.person_pin, color: Colors.white, size: 100 ),
      ),
    );
  }
}

// privare , contenedor morado 
class _PurpleBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size; // diemensiones pantalla

    return Container(
      width: double.infinity,
      height: size.height * 0.4, // 40 %
      decoration: _purpleBackground(), // equivale color , vamos a hacerlo gradiente , extraer metodo 
      child: Stack( // para colocar widget encima de otros , circulitos
        children: [
          Positioned(child: _Bubble(), top: 90, left: 30 ),
          Positioned(child: _Bubble(), top: -40, left: -30 ),
          Positioned(child: _Bubble(), top: -50, right: -20 ),
          Positioned(child: _Bubble(), bottom: -50, left: 10 ),
          Positioned(child: _Bubble(), bottom: 120, right: 20 ),
        ],
      ),
    );
  }

  // metodo de tipo ... regresa widget del mimo tipo 
  BoxDecoration _purpleBackground() => BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]
    )
  );
}


// este widget : circulitros vs ser usado varias veces  en fondo 
class _Bubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}