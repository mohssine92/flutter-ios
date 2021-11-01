// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider(
      {Key? key,
      required this.movies,
      required this.onNextPage, // recibo por nombre cualquier data paginada , asi este scrollcard reutulizable 100%
      this.title})
      : super(key: key);

  @override
  State<MovieSlider> createState() =>
      _MovieSliderState(); // necesita estar sujeto a un widget que tiene scroll

}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // ejecuta scope la primer vez que este widget es construido
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        // restar cuando este cerca al final del scrol maximo
        // llamar provider
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // ejecuta scope cuando widget va ser distruido

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (widget.movies.isEmpty) {
      // segnifica no hay movies toda en espera de la resulucion de la hhtp request provider

      // ignore: sized_box_for_whitespace
      return Container(
        width: double
            .infinity, // ihaul que widget que va terminar redirizando abajo
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(), // loading
        ),
      );
    } // antes de la construccion del swiper , porque en un instante la coleccion es vacia swiper rewuire 3 elementos sino se bloque la app
    // evito err  _MoviePoster( movies[index] )

    return Container(
      width: double.infinity,
      height: 260,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title !=
              null) // si false o nul no se muestra el unco siguiente widget
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20), // pading only horizontal
              child: Text(
                widget.title!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(height: 5),
          Expanded(
            //listView.bulder necesita tonara espacionrespecto al padre sino da err .
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length, // lenght coleccion a ciclar
              itemBuilder: (_, int index) => _MoviePoster(widget.movies[index],
                  '${widget.title}-$index-${widget.movies[index].id}'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const _MoviePoster(this.movie, this.heroId); // arg posicional 109

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      //color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            // navifacion
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: movie.heroId!, // ventaja de tavajar con modelo
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullBackdropPath),
                  width: 130,
                  height: 190,
                  fit: BoxFit
                      .cover, // parque se adapte al tamaño caracteristicas del container padre (border)
                ),
              ),
            ),
          ),

          SizedBox(height: 5), // separacion

          Text(
            movie.title,
            maxLines: 2, // when rich final creat new line
            overflow: TextOverflow.ellipsis, // resolve prob text largo with ...
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
