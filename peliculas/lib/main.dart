import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:peliculas/providers/movies_provider.dart';

// puede ser que tengamos muchas importacion vamos a cambiarla a una importacion nada  mas  95
import 'package:peliculas/screens/screens.dart';

// en apps anteriores lo primero que llamamos es MyApp , ahora occupamos provedores asi llamamos widget encargado de instanciar nuestro providers y en su child llammaos a my app
// asi lo primero a crear es appsate y luego myapp . asi tenemos providers de nivel superior
void main() => runApp(AppState());

// es widget  - realmente tenemos aqui el estado mis providers
// ignore: use_key_in_widget_constructors
class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // usamos Multiprovider si porsi acaso requerimos varios providers en nuestra app
      providers: [
        ChangeNotifierProvider(
            create: (_) => MoviesProvider(),
            lazy:
                false), // true lazy load instancia cuando es necesario - false intanciado al levantar la app
        // mas providers
      ],
      child: MyApp(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // desahbilitar text debug en appbar
      title: 'Películas',
      initialRoute: 'home',
      routes: {
        // ignore: prefer_const_constructors
        'home': (_) =>
            // ignore: prefer_const_constructors
            HomeScreen(), // (_) => tenemos build context pero no ne necesito por eso
        // ignore: prefer_const_constructors
        'details': (_) => DetailsScreen(),
      },
      theme: ThemeData.light().copyWith(
          // copyWith me permite hacer copia excepto lo que voy a añadir
          appBarTheme: const AppBarTheme(
              color: Colors
                  .indigo // cambiar color del app bar de forma global en la app
              )),
    );
  }
}

// ThemeData.dark() dos tema por defecto 86
// theme lo que configurado en them avitamos de cambiar color etc en cada appbar de cada scaffold
