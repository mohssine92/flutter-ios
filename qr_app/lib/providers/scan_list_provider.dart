import 'package:flutter/material.dart';

import 'package:qr_app/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado =
      'http'; // por defect // F:cargar por tipo lo mofifica

  Future<ScanModel> nuevoScan(String valor) async {
    // valor producto del button sacan

    final nuevoScan = ScanModel(valor: valor);

    final id = await DBProvider.db.nuevoScan(nuevoScan);
    // Asignar el ID de la base de datos al modelo despues de insertar
    nuevoScan.id = id;

    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
      // porque si estoy en direcciones y escaneo geolocation no tengo porque actualizar  en absoluto - actualizamos cuando cambiamos opcion
      // notificar widgets nwcwsitan ser dibujados
    }

    return nuevoScan;
  }

  cargarScans() async {
    final scans = await DBProvider.db.getTodosLosScans();
    this.scans = [
      ...scans
    ]; // remplazar estado interior pero el nuevo estado que esta en aqui
    notifyListeners();
  }

  cargarScanPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...scans];
    tipoSeleccionado = tipo; //
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners(); // asi cualquier widget eschucando a scans sera notificado realtiem
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    // no notifico en este caso porque estoy usando dissmised deslizando borrando visualmente
  }
} // un servicio centralizado es lugar donde vamos a buscar informacion realcionada a los escans
// se derimos directamente al modelo db no va a notificar iu , pero este servicio si
// metodos asociados a experiencia de usario
