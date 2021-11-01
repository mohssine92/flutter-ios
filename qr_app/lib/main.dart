import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_app/providers/ui_provider.dart';
import 'package:qr_app/providers/scan_list_provider.dart';

import 'package:qr_app/pages/home_page.dart';
import 'package:qr_app/pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // es como singlton tener instacia para consumir desde los widgets del arbol
      providers: [
        // instancia del provider accedida por widgets del arbol
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'mapa': (_) => MapaPage(),
        },
        // tema app global
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
      ),
    );
  }
}
