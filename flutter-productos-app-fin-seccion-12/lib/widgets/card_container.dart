import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {

  final Widget child;

  const CardContainer({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric( horizontal: 30 ), // vertical tambien puede
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all( 20 ),
          decoration: _createCardShape(), // exter ... , decoracion de un container
          child: this.child, // contenido 
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black12, // color sombre
        blurRadius: 15,
        offset: Offset(0, 5), // tendencia de sombra
      )
    ]
  );
}