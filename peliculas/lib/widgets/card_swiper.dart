import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:peliculas/models/movie.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // me gustaria tomar % de la pantalla por eso uso Mediaquery widget me facilita infromacion relacionada a la plataforma que esta
    // corriendo diemnsiones orientaciones y mucha cosa
    final size = MediaQuery.of(context)
        .size; // en este caso me gustaria saber alto y ancho del despositico

    if (movies.isEmpty) {
      // try wtih true
      // segnifica no hay movies toda en espera de la resulucion de la http request provider

      // ignore: sized_box_for_whitespace
      return Container(
        width: double
            .infinity, // ihaul que widget que va terminar redirizando abajo
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(), // loading
        ),
      );
    } // antes de la construccion del swiper ,   itemBuilder: (_, int index) { : requiere 3 elementos - img se traen de proceso asyncrono , instantaneamente produce err

    // ignore: sized_box_for_whitespace
    return Container(
        width: double
            .infinity, // todo ancho posible basado en padre: widget donde se encaja en este caso es column  no infinidad
        height: size.height *
            0.5, //  voy multiplicado por % necesito para el espacio container donde va carrousel
        //color: Colors.red,
        child: Swiper(
          // asegura de importarlo del packages que acabamos de installar
          itemCount: 20, // cantida de tarjetas a manejar
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (_, int index) {
            final movie = movies[index];

            movie.heroId =
                'swiper-${movie.id}'; // en este instance - es objeto provider trabajamos por referncias

            return GestureDetector(
              // clicknavig
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: movie), // 3arg para mandar argumentos

              child: Hero(
                tag: movie.heroId!, // unico en the widget scrren
                child: ClipRRect(
                  // border
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movie.fullBackdropPath),
                    fit: BoxFit
                        .cover, // parque se adapte al tamaño caracteristicas del container padre (border)
                  ),
                ),
              ),
              // ),
            );
          },
        ));
  }
}
