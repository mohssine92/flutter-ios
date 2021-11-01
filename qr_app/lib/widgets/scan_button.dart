import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_app/providers/db_provider.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:qr_app/utils/utils.dart';

import 'package:qr_app/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 0, // out sombra
        child: const Icon(Icons.filter_center_focus),
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#E80751', 'close', false, ScanMode.QR); // flash false

          //print(barcodeScanRes);

          if (barcodeScanRes == '-1') {
            return;
          }

          // para hacer insercion - estoy dentro de un metodo no builder method esto no necesita que se redibujo daria err - listen false
          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);

          // con fin no insertar basura en db , en este caso me imorta solo https y geo
          final newScan = ScanModel(valor: barcodeScanRes);
          if (newScan.tipo == 'unknown') {
            //print('unknow');

            return;
          }

          final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

          launchURL(context, nuevoScan);
        });
  }
}
