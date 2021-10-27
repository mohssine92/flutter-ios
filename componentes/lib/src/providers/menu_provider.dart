import 'package:flutter/services.dart'
    show rootBundle; //imprt necesary for read file json
// exporto solo lo que necesito o hacer visible rootBundle:object

import 'dart:convert'; //json decode

class _MenuProvider {
  // class  normal

  List<dynamic> opciones = []; // any dynamic

  _MenuProvider() {
    // constructor
    // cargarData();  es un future asi no puedo implementar asyn await en construcor
  }

  Future<List<dynamic>> cargarData() async {
    final resp =
        await rootBundle.loadString('data/menu_opts.json'); // future es promise

    Map dataMap =
        json.decode(resp); // 65 - convertir json string a un Map:objeto js
    opciones = dataMap['rutas'];

    return opciones;
  } // el echo returna un future en un statelesswidget con algo llammado futurebuilder
}

// de esta menera este archivo solo expone una instancia de _MenuProvider();
final menuProvider = _MenuProvider();

// no es importante la exportacion ,solo la imporacion del archivo
