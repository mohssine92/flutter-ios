// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class BasicDesignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // Imagen
        Image(
            image: AssetImage(
                'assets/landscape.jpg')), // because he is in the assets

        // Title
        Title(), // puede mandar args

        // Button Section
        ButtonSection(),

        Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
                'Laboris enim occaecat do et id velit dolore qui Lorem. Dolore ut incididunt consequat sunt do nisi aliqua pariatur ex quis cupidatat. Enim aliqua deserunt voluptate Lorem Lorem in cillum aute veniam. Ipsum irure eiusmod occaecat qui dolor consectetur aliquip deserunt sint labore qui aute mollit. Veniam duis adipisicing do mollit aliquip minim.'))
      ],
    ));
  }
}

class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //ignore: prefer_const_constructors
      margin: EdgeInsets.symmetric(
          horizontal: 30, vertical: 10), // padding al child
      child: Row(
        //envolver en container con fin de : modify stetic , posiciones , padding , separaciones ,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // alinear de manera horizontal en row - en col al reves
            //ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                'Oeschinen Lake Campground',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Kandersteg, Switzerland',
                  style: TextStyle(color: Colors.black45)),
            ],
          ),

          Expanded(
              child: Container()), // expando toma espacio que pueda espacio

          Icon(Icons.star, color: Colors.red),
          Text('41'),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
          CustomButton(icon: Icons.call, text: 'Call'),
          // ignore: prefer_const_constructors
          CustomButton(icon: Icons.map_sharp, text: 'Route'),
          // ignore: prefer_const_constructors
          CustomButton(icon: Icons.share, text: 'Share'),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomButton({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 30,
        ),
        Text(text, style: const TextStyle(color: Colors.blue))
      ],
    );
  }
}
