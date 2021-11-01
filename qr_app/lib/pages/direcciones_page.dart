import 'package:flutter/material.dart';
import 'package:qr_app/widgets/scan_tiles.dart';

class DireccionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return ScanTiles(tipo: 'http');
    /* return Center(
      child: Text('Direcciones Page')   
    ); */
    return ScanTiles(tipo: 'http');
  }
}
