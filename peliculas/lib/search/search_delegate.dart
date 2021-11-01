// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search';

  @override
  List<Widget> buildActions(BuildContext context) {
    // clear text input
    return [
      IconButton(
        // ignore: prefer_const_constructors
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // exit search
    return IconButton(
      // ignore: prefer_const_constructors
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Widget _emptyContainer() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 130,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: (_, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!; // confia  va tener data

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _MovieItem(movies[index]));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // se dispara cpor cada tecla

    if (query.isEmpty) {
      // input vacio
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context,
        listen:
            false); // no quiero que se redibuja de manera inecesaria - porque se redibuja unicamente cuando stream emite salida

    moviesProvider.getSuggestionsByQuery(query); //send query to strem ,

    // la funcion suggestionStream returna un stream asi implemento StreamBuilder es igual que Futurbuilder
    return StreamBuilder(
      // se redibuja unicamente cuando suggestionStream emit un valor
      stream:
          moviesProvider.suggestionStream, // escuchar la salida del stream .
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        // snapshot result stream or future

        if (!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!; // confia  va tener data

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _MovieItem(movies[index]));
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem(this.movie); // posicional arg

  @override
  Widget build(BuildContext context) {
    // build the list

    movie.heroId =
        'search-${movie.id}'; //hero animacion - gracias que object trabaja por referencia - mantener la forma de instancia la clase de nivel alto para tener la misma refrencia de instancia en toda la app asi mutamos la data

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details',
            arguments: movie); // redireccinar with arg permite retrocede
      },
    );
  }
}
