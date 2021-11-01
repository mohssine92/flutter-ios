// ignore_for_file: prefer_const_constructors

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/credits_response.dart';

import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';

//102
class CastingCards extends StatelessWidget {
  // autores de la pelicula etc

  final int movieId;

  // ignore: use_key_in_widget_constructors
  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context,
        listen: false); // my future are in the provider
    // false no me interesa redibuja si hay cambios when notify listner he've called
    // en vez de regresar un container regresamos un future

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<dynamic>> snapshot) {
        // no se entiende porque rechaza tipo cast
        if (!snapshot.hasData) {
          // asyn cuando se dispara no tengo informacion
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<dynamic> cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(
              bottom:
                  30), // margin abajo al container - me guta que el user suba un poco mas con scrool no queda pegado abajo
          width: double.infinity,
          height: 180,
          // color: Colors.red,
          child: ListView.builder(
            // aqui donde meto las tarjetas
            itemCount: cast.length, // cuantity for build cards
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastCard(cast[
                index]), // observacion mientras hacemos scrool va cargando daya necesaria para la construccion del widget
          ),
        );
      },
    );
  }
}

//102
class _CastCard extends StatelessWidget {
  // private juste will use it into this file

  final Cast actor;

  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    //print(actor.name);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
