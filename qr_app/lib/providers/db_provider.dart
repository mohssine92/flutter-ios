import 'dart:io';

import 'package:sqflite/sqflite.dart'; // tipo Database
import 'package:path/path.dart'; // join

import 'package:path_provider/path_provider.dart';

import 'package:qr_app/models/scan_model.dart';
export 'package:qr_app/models/scan_model.dart';

// la idea de este dbprovider tener un singlton - paraque no importe donde yo instancie siempre voy a tomar la misma instancia creada  de esta db
// al reves de otros providers deben ser instanciados en nivel alto de la app para tener la misma instancia durante la vida de la app

class DBProvider {
  //donde mantener instancia de nuestra db - sqflite : es un archivo db se encuentra en el dispositivo depende si es anfroido o ios etc etc
  static Database? _database;

  // crear instancia internamente de esta clase personalizada - _ constructor privado - implementacion de singlton
  static final DBProvider db = DBProvider._();

  // definicion del constructor privado
  DBProvider._();

  // para acceder al object _database - getter
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } // singlton si existe no muto la instancia

    // si es la primera vez y el objeto es null , procemos la creacion de la structure db
    _database = await initDB();

    return _database!;
  }

  //procedimiento para prepara nuestra db
  Future<Database> initDB() async {
    // obtener path de db sqflite
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // build utl de mi db
    final path = join(documentsDirectory.path,
        'ScansDB.db'); // build url donde estara nuestra db

    //print(path);

    return await openDatabase(path,
        version:
            1, // cambios estructurales en db son versiones - borra table , edit , debe incrementar en en secuecia al respeto para hacer el combio estructural en db , sino no puede
        onOpen: (db) {}, // cuando se abra db podemos ejecutar algo
        onCreate: (Database db, int version) async {
      // creacion structura db
      await db.execute('''
             CREATE TABLE Scans(
             id INTEGER PRIMARY KEY,
             tipo TEXT,
             valor TEXT
            )
          '''); // consejor borra db recrearla 158 min 10
    });
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id; // id se autogenera pero necesito insertarlo
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // Verificar la base de datos - espere hasta que este lista
    final db = await database; // db variable local es de tipo Database

    final res = await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor )
        VALUES( $id, '$tipo', '$valor' ) 
    ''');

    return res;
  } // opcion 1 es mucho trabajo pero seria bien para entender proceso de rawInsert

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert(
        'Scans',
        nuevoScan
            .toJson()); // ventaja inserta todos campos modelo - rapid a escribir

    print(res);
    // res es lastId inserted ;
    return res;
  } // insersacion rapida equivale nuvoScanRow

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [
      id
    ]); // db.query('Scans') => trea all - 160 para masa filtros

    //print(res);
    return res.isNotEmpty
        ? ScanModel.fromJson(res.first) // instancia del modelo cargada de db
        : null;
  }

  Future<List<ScanModel>> getTodosLosScans() async {
    final db = await database;
    final res = await db.query('Scans');

    //print(res);
    return res.isNotEmpty
        ? res
            .map((s) => ScanModel.fromJson(s))
            .toList() // map es un meto tiene todo tipo list  - map regresa iterable lo coonvierto el lista
        : [];
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
       SELECT * FROM Scans WHERE tipo = '$tipo'    
     ''');

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?',
        whereArgs: [
          nuevoScan.id
        ]); // mucho cuidado sin condicion actualizara toda tabla

    // id updated
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    //print(res);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans    
    ''');

    // laist id deleted , after delete all will id is 0
    return res;
  }
}
