import 'dart:async'; // stream

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

import 'package:peliculas/helpers/edboucer.dart';

class MoviesProvider extends ChangeNotifier {
  // props privadas
  final String _apiKey =
      'ebdcb0209f685902d02cebb6c7b97c8f'; // my key created por mi
  final String _baseUrl =
      'api.themoviedb.org'; // https no hace falta porque Uri.https lo va colocar por mi
  final String _language = 'en-EN';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {}; // llave id pelicula

  int _popularPage = 0;

  final debouncer = Debouncer(
    // ignore: prefer_const_constructors
    duration: Duration(milliseconds: 500),
  );

  // Crecion de stream - ver youtube hay bastante material sobre el tema - la salida va ser list de movie - .broadcast porque muchos objeto pueden estan suscritos a este stream
  // esto es un stream controler no es un stream : lo cual tiene muchas funcionalidades que voy a necesitar en un stream  : por ejemplo añadir valores , suscribirme a los emisiones del mismo
  // recuerda cualquier streamController se debe  cerrar en algun lugar , porque siempre va estar escuchandose , en este caso no necesito cerrarlo siempre necesito escucharlo .
  final StreamController<List<Movie>> _suggestionStreamContoller =
      StreamController.broadcast();

  // Definir el stream que voy a estar ecuchando desde afuera , desde el streamBuilder
  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamContoller.stream; // va ser un getter

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    // int page  obligatorio
    // [int page = 1] opcional si no se manda pues sera 1
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(
        jsonData); // nowPlayingResponse : data a consumir en nuestros componentes
    //print(nowPlayingResponse.results[1].genreIds);

    onDisplayMovies = nowPlayingResponse.results;

    //print(onDisplayMovies[0].genreIds);

    notifyListeners();
  } // es un objeto provider puedo acceder a cualquir de sus metodos y props puesto que no sean privadas

  getPopularMovies() async {
    //108

    _popularPage++; //110

    //print(_popularPage);

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);

    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    // destructurin para mantener reesultados actuales , voy a llamar a varias paginas 1, 2 , 3 etc .. voy agregando al manteniendo el actual

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    // Mostrar actores y mantener en memoria
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    print('ask data of the server');

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    // cada vez entro a una peliculaa sera almacenado como llave id de la peli y object de actores asi es , si id de la peli froma parte de este object segnifica ya esta la data en objeto - evitar hacer peticion aservidor y consumir datos al usuario
    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  } // este future debe ser disparado en algun lugar

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    // no regresa nada solo emite valor de su arg al strem abierto

    debouncer.value = ''; // seter
    debouncer.onValue = (value) async {
      // es el metodo que voy a mandar a dispara cuando pasan los 500ms
      // dar valor al metodo definido en deboucer
      //print('Tenemos valor a buscar: $value');   // value es laque pasamos desde la clase la tenemos en memoria , gracias al proceso debajo
      final results = await searchMovies(value);
      _suggestionStreamContoller.add(results);

      // print(results);
    };

    // dar valor al arg quecva requerir el metodo cuando se disparar
    // ignore: prefer_const_constructors
    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      // se dispara cada x tiempo por eso lo cancelo enseguida
      debouncer.value =
          searchTerm; // seter ejecuta internamente onvalue definida arriba
    });

    // ignore: prefer_const_constructors - evitar 2 y 3 ... dispares, prefer_const_constructors
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
