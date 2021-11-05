import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';

// Pantalla intermedia , apena entramos a la app siempre rederigemos user a esta pantalla :
// - sirve est pantalla para verificar token o hacer cargas previas de algun pantalla de la app

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // encontrar AuthService en context
    // no nesesito redibujar nada en este widget - no escuche los cambios que esten occuriendo en este authservice
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return Text('');

            if (snapshot.data == '') {
              // builder debe returnar un widget bien . pero no se puede redericcionar normal - erdireccionar y media construccion - por esoo . 241
              Future.microtask(() {
                // transiccion de pantalla no brisca
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LoginScreen(),
                        transitionDuration: Duration(seconds: 0)));
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen(),
                        transitionDuration: Duration(seconds: 0)));
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
