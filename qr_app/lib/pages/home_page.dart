import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_app/providers/scan_list_provider.dart';
import 'package:qr_app/providers/ui_provider.dart';

import 'package:qr_app/widgets/custom_navigatorbar.dart';
import 'package:qr_app/widgets/scan_button.dart';

// condicionals body
import 'package:qr_app/pages/mapas_page.dart';
import 'package:qr_app/pages/direcciones_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // quitar sombra
        title: const Center(child: Text('Historial')), // false dentro de metodo
        actions: [
          IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () {
                Provider.of<ScanListProvider>(context,
                        listen:
                            false) // listen false estamos dentro de un metodo simple
                    .borrarTodos();
              })
        ],
      ),
      //body: condicional body
      body: _HomePageBody(),
      // icones boton
      bottomNavigationBar: CustomNavigationBar(),
      // butoon y su posicinamiento
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floatingActionButton - aprobarmas props
    );
  }
}

// privdo solo sirve en ete archivo
class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // provider instanciado de nivel alto en la app lo que hace la misma instancia refrencia y tadas scafoldes de la app - singlton
    // me permite maniopular referncias del objeto centralizado para todos widgets
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt; // getter

    final scanListProvider = Provider.of<ScanListProvider>(context,
        listen:
            false); // false no redibujar - en esta altura solo mando para traer data de db - luego cuando el widget se carga va a solicitar la dara y redibujar

    // regresa un widget de manera condicional
    switch (currentIndex) {
      //aqui sabemos que apgina a mostrars

      case 0:
        scanListProvider.cargarScanPorTipo(
            'geo'); // prepara data mando a cargar data en memoria de la clase
        return MapasPage();

      case 1:
        scanListProvider.cargarScanPorTipo(
            'http'); // prepara data mando a cargar data en memoria de la clase
        return DireccionesPage();

      default:
        return MapasPage();
    }
  } // widget privado solo servira en este archivo

}
