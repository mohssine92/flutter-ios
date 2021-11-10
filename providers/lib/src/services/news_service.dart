import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:providers/src/models/news_models.dart';
import 'package:providers/src/models/category_model.dart';

import 'package:http/http.dart' as http;

// variables privadas - solo funcionan  dentro de este archivo
const _URL_NEWS = 'newsapi.org';
const _APIKEY = '194203ee3fd64166be13004e34d34e1a';

// colocar NewsService en un punto mas alto del arbol de los widgets usando provider
class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = "business";

  bool _isLoading = true;

  // Importante los strings de categories , devebn ser escritas igual como pide api de busqueda
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  // crear mapa para guardar recien busquedas en catche y el user pensara que mi app mas rapida
  // si manejamos mas qeu 100 categorias - empezamos a borra anteriorres
  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();

    // inicialiso las llaves con list vacias como valor - porque si intento seleccionar para insertar en una llave no existe proto da err
    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });

    getArticlesByCategory(_selectedCategory);
  }

  getTopHeadlines() async {
    final url = Uri.https(
        _URL_NEWS, '/v2/top-headlines', {'apiKey': _APIKEY, 'country': 'ma'});

    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    // psuh en list
    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    _selectedCategory = valor;

    print(_selectedCategory);

    _isLoading = true;
    getArticlesByCategory(valor);

    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada =>
      categoryArticles[selectedCategory]!;

  getArticlesByCategory(String category) async {
    //evitar request inecesario - list de categoria recien cargada esta en memoria deeste singlton provider
    if (categoryArticles[category]!.isNotEmpty) {
      print('no peticion recien cargado .. en catche');
      _isLoading = false;
      notifyListeners();
      return categoryArticles[category];
    }

    final url = Uri.https(_URL_NEWS, '/v2/top-headlines',
        {'apiKey': _APIKEY, 'country': 'ma', 'category': category});
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    print(newsResponse.articles);

    // confi la categoria llave existe donde vas a insertar - caso de catche intenso no delet llave vaciar valoe de llave es todo
    categoryArticles[category]!.addAll(newsResponse.articles);

    _isLoading = false;
    notifyListeners();
  }

  validarImg(String url) {
    print(url);
  }
}
