import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:providers/src/models/news_models.dart';

import 'package:providers/src/services/news_service.dart';

import 'package:providers/src/widgets/lista_noticias.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewsService>(context);
    final List<Article> headlines = newService.headlines;
    // return Scaffold(
    //   // widget reutulizable
    //   body: ListaNoticias(headlines),
    // );

    // loading : simpre es bueno implementarlo - porque hay conexiones lentas : paar tarer recursos via http
    return Scaffold(
        body: (headlines.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : ListaNoticias(headlines));
  }

  @override
  // TODO:  ver la mezcla : true para mantener state de widget - en este caso scrol donde lo deje .- no destrocer al salir del pantalla y volver
  bool get wantKeepAlive => true;
}
