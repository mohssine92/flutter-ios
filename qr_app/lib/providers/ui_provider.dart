import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  // ChangeNotifier requerido

  int _selectedMenuOpt =
      1; // esta prop para saber indice seleccionado - body condicional

  // getters
  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  // setters
  set selectedMenuOpt(int i) {
    _selectedMenuOpt = i;
    notifyListeners(); // al setear cambios notifico a  los escuchadores que se redibujen
  }
}


// logica centralizada para mostrar body condicinalmente en el button seleccionado en otro widget
// importante esta clase debe estar instanciada en nivel alto de la app asi para mantener la misma refrencia a lo largo de vida de la app