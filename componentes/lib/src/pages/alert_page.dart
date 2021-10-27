import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // metodo pintar en pantalla un widget o widget de widgets returnado

    return Scaffold(
      // widget pantalla
      appBar: AppBar(
        title: const Text('Alert Page'),
      ),
      body: Center(
        // ignore: deprecated_member_use
        child: RaisedButton(
          // alternativa 75
          child: const Text('Mostrar Alerta'),
          color: Colors.blue,
          textColor: Colors.white,
          shape: const StadiumBorder(),
          onPressed: () => _mostrarAlert(
              context), // dispara una alerta , () => xxxx() , no asi xxx() , porue quiero recibir arg
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_location),
        onPressed: () {
          Navigator.pop(// regresar pagina anterior
              context); // atraves del context sabra cual es pagina anterior
        },
      ),
    );
  }

  void _mostrarAlert(BuildContext context) {
    // my metodo
    showDialog(
        // es una clse
        context: context, // contexto de nuestr apagina
        barrierDismissible:
            true, // true cerra dialgo click fuera del mismo al reves boolean
        builder: (context) {
          // Funcion encargada de crear crear todo dialogo - tengop que regresar un widget

          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: const Text('Titulo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Text('Este es el contenido  de la caja de la alerta'),
                //Text('hi worl'),
                FlutterLogo(size: 100.0)
              ],
            ),
            actions: <Widget>[
              // acciones del dialogo - lista de botones
              // ignore: deprecated_member_use
              FlatButton(
                child: const Text('Cancelar'),
                onPressed: () =>
                    Navigator.of(context).pop(), // salir del dialogo
              ),
              // ignore: deprecated_member_use
              FlatButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
