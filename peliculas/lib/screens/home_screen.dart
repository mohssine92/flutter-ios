import 'package:flutter/material.dart';

import 'package:peliculas/widgets/widgets.dart';

import 'package:provider/provider.dart';
import 'package:peliculas/providers/movies_provider.dart';

import 'package:peliculas/search/search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(
        context); // liseten en true por defecto , redibujate cuando se llame notify - provider class ,

    //print(moviesProvider.onDisplayMovies);

    return Scaffold(
        // page
        appBar: AppBar(
          title: const Center(child: Text('Películas en cines')),
          elevation: 0, // pegado sin sombre
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined), // lupita searh
              onPressed: () => showSearch(
                  context: context,
                  delegate:
                      MovieSearchDelegate()), //MovieSearchDelegate clasee reqiere ciertas condiciones
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(// columna me permite poner widgets uno abajo de otros
              // ignore: prefer_const_literals_to_create_immutables
              children: [
            // providers : la idea este cardSwiper se quede reutulizable , asi le mando data , no la manejo internamente
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populares',
              onNextPage: () =>
                  moviesProvider.getPopularMovies(), // usada en scroll
            ),
          ]),
        ));
  }
}

//MovieSlider()// ojo si hago otro sale de la dimensiones de la pantalla no tenemos applicado scroll hat varios widget para hacerlo
