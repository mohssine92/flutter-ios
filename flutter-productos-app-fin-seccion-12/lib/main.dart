import 'package:flutter/material.dart';

import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';

import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MultiProvider porque voy a crear varios providers
    // podemos decir tenemos nuestros servicios injectados en el contexto en un punto mas alto de la app asi atraves del context obtengo acceso a los mismo en cualquier widget de al app
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(
          create: (_) => ProductsService(),
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'checking',
      routes: {
        'checking': (_) => CheckAuthScreen(),
        //
        'login': (_) => LoginScreen(),
        'register': (_) => RegisterScreen(),
        //
        'home': (_) => HomeScreen(),
        'product': (_) => ProductScreen(),
      },
      // al hacer esto en cualquier lugar de mi app usando las prop staticas de este service ...puedo usar snackbar
      scaffoldMessengerKey: NotificationsService.messengerKey,
      // personalizar elementos de forma global enl app
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.indigo),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo, elevation: 0)),
    );
  }
}
