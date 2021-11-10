import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:providers/src/models/category_model.dart';
import 'package:providers/src/services/news_service.dart';

import 'package:providers/src/theme/tema.dart';
import 'package:providers/src/widgets/lista_noticias.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    // print(newsService.headlines);
    // safearer espacio iphone
    return SafeArea(
      child: Scaffold(
          // uno pago de otro
          body: Column(
        children: <Widget>[
          _ListaCategorias(),
          if (!newsService.isLoading)
            Expanded(
                child: ListaNoticias(
                    newsService.getArticulosCategoriaSeleccionada)),
          if (newsService.isLoading)
            const Expanded(
                child: Center(
              child: CircularProgressIndicator(),
            ))
        ],
      )),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Category> categories =
        Provider.of<NewsService>(context).categories;

    // container
    return Container(
      width: double.infinity,
      height: 80,
      // lista
      child: ListView.builder(
        //physics paraue se ve igual tanto en ios como android
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categories[index].name;
          // buil de la lista
          return Padding(
            padding: EdgeInsets.all(8),
            // uno bajo de otro
            child: Column(
              children: <Widget>[
                //Icon(categories[index].icon),
                _CategoryButton(categories[index]),
                SizedBox(height: 5),
                // solo primer letra en mayuscula y concateno las demas letras normales
                Text('${cName[0].toUpperCase()}${cName.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    // con fin de interactuar
    final newsService = Provider.of<NewsService>(context);
    // newsService.selectedCategory = 'business';

    return GestureDetector(
      // GestureDetector para dar accion
      onTap: () {
        // print('${ categoria.name }');
        // algo tiene provider cuando estamos en algun evento que se dispara eato no deve redibujar - sino tira err
        final newsService = Provider.of<NewsService>(context, listen: false);
        // con fin de saber que esmaos seleccionando para condiciones
        newsService.selectedCategory = categoria.name;
      },
      // container par dar estilos
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          categoria.icon,
          // color condicionalmente icono selecionado
          color: (newsService.selectedCategory == categoria.name)
              ? miTema.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
