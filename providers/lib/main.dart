import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:providers/src/services/news_service.dart';

import 'package:providers/src/theme/tema.dart';

import 'package:providers/src/pages/tabs_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // lazy true : hasta que le ejecute un widget va a hacer la instancia
        ChangeNotifierProvider(create: (_) => NewsService(), lazy: true),
      ],
      child: MaterialApp(
        title: 'Material App',
        // tema global de la app
        theme: miTema,
        debugShowCheckedModeBanner: false,
        home: TabsPage(),
      ),
    );
  }
}
