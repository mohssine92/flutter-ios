import 'package:flutter/material.dart';

//import 'package:componentes/src/pages/home_temp.dart';
import 'package:componentes/src/pages/home_page.dart';
import 'package:componentes/src/pages/avatar_page.dart';
import 'package:componentes/src/pages/card_page.dart';
import 'package:componentes/src/pages/animated_container.dart';
import 'package:componentes/src/pages/input_page.dart';
import 'package:componentes/src/pages/slider_page.dart';
import 'package:componentes/src/pages/listview_page.dart';

import 'package:componentes/src/pages/alert_page.dart';

//import 'package:componentes/src/pages/card_page.dart';
//import 'package:componentes/src/pages/animated_container.dart';
//import 'package:componentes/src/pages/input_page.dart';
//import 'package:componentes/src/pages/slider_page.dart';
//import 'package:componentes/src/pages/listview_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    // strings deben escribir correctamente como estan en opt['ruta']
    // string aqui sabran los compañeros las rutas trabajadas en la app - tarabajr con diferentes pantallas
    // ignore: prefer_const_constructors
    '/': (context) => HomePage(),
    'alert': (context) => const AlertPage(),
    'avatar': (context) => const AvatarPage(),
    'card': (context) => const CardPage(),
    'animatedContainer': (context) => const AnimatedContainerPage(),
    'inputs': (BuildContext context) => const InputPage(),
    'slider': (BuildContext context) => const SliderPage(),
    'list': (BuildContext context) => const ListaPage(),
  };
}
