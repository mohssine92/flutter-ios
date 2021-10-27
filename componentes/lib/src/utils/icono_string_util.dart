import 'package:flutter/material.dart'; // uso Icon() widget

final _icons = <String, IconData>{
  'add_alert': Icons.add_alert,
  'accessibility': Icons.accessibility,
  'folder_open': Icons.folder_open,
  'donut_large': Icons.donut_large,
  'input': Icons.input,
  'list': Icons.list,
  'tune': Icons.tune,
}; // preparo los icones en funcion de nombree strings recibidos de un recurso
// recuerda si no preparamos un icon que viene de db aqui no se va a mostrar

Icon getIcon(String nombreIcono) {
  // nombreIcono llave

  return Icon(_icons[nombreIcono], color: Colors.blue);
  // prop posicional puede ser null
}

// funcion regresa un icono en base string que estoy mandando , _icons podra crecer
