import 'package:flutter/material.dart';

import 'package:productos_app/screens/screens.dart'; // all screnns

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'login',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScreen(),
      },
      theme: ThemeData.light().copyWith(
          //  cambiar todo color Fondo de scafold a nivel global de la app
          scaffoldBackgroundColor: Colors.grey[300]),
    );
  }
}
