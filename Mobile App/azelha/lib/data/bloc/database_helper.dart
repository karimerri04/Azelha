import 'package:azelha/data/model/scan_db_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'base_bloc.dart';

class DatabaseHelper extends BaseBloc {
  String path;

  DatabaseHelper._();

  static final DatabaseHelper db = DatabaseHelper._();

  Database _database;

  Future<int> delete() async {
    final db = await database;
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Azelha.db');

// Delete the database
    await deleteDatabase(path);
    return await db.delete(
      'ScanItemsDB',
    );
  }

  deleteDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'AzelhaApp.db');
    await deleteDatabase(path);
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await init();
    return _database;
  }

  init() async {
    deleteDB();
    String path = await getDatabasesPath();
    path = join(path, 'AzelhaApp.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE ScanItemsDB (_id INTEGER PRIMARY KEY, barcode_number TEXT, barcode_type TEXT, barcode_formats TEXT, mpn TEXT, model TEXT, asin TEXT, package_quantity TEXT, size TEXT, length TEXT, width TEXT, height TEXT, weight TEXT, description TEXT, image TEXT, points INTEGER, status TEXT);');

      print('New table created at $path');
    });
  }

  Future<int> deleteScanItemInDB(ScanItemDB scanItemToDelete) async {
    final db = await database;
    return await db.delete('ScanItemsDB',
        where: 'barcode_number = ?',
        whereArgs: [scanItemToDelete.barcode_number]);
  }

  // Scan Item
  Future<List<ScanItemDB>> getScanItemsFromDB() async {
    final db = await database;
    List<ScanItemDB> scanItemsList = [];
    List<Map> maps = await db.query('ScanItemsDB', columns: [
      '_id',
      'barcode_number',
      'barcode_type',
      'barcode_formats',
      'mpn',
      'model',
      'asin',
      'package_quantity',
      'size',
      'length',
      'width',
      'height',
      'weight',
      'description',
      'image',
      'points',
      'status'
    ]);
    if (maps.length > 0) {
      maps.forEach((map) {
        print('THE MAP IS $map');
        scanItemsList.add(ScanItemDB.fromMap(map));
      });
    }
    return scanItemsList;
  }

  Future<ScanItemDB> getScanItemFromDB(int id) async {
    final db = await database;
    ScanItemDB scanItemDB;
    List<Map> maps = await db.query('OrderItemsDB',
        columns: [
          '_id',
          'barcode_number',
          'barcode_type',
          'barcode_formats',
          'mpn',
          'model',
          'asin',
          'package_quantity',
          'size',
          'length',
          'width',
          'height',
          'weight',
          'description',
          'image',
          'points',
          'status'
        ],
        where: 'barcode_number = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      scanItemDB = ScanItemDB.fromMap(maps.first);
    }
    return scanItemDB;
  }

  Future<int> updateScanItemInDB(ScanItemDB scanItem) async {
    print("the new value of qnt is" + scanItem.package_quantity.toString());
    final db = await database;
    return await db.update('OrderItemsDB', scanItem.toMap(),
        where: 'barcode_number = ?', whereArgs: [scanItem.barcode_number]);
  }

  Future<ScanItemDB> saveScanItem(ScanItemDB newScanItem) async {
    var db = await database;
    if (newScanItem.barcode_type.trim().isEmpty)
      newScanItem.barcode_type = 'no barcode';
    int id = await db.transaction((transaction) {
      transaction.rawInsert(
          'INSERT into ScanItemsDB(barcode_number,barcode_type,barcode_formats,mpn,model,asin,package_quantity,size,length,width,height,weight,description,image,points,status) VALUES '
          '("${newScanItem.barcode_number}", "${newScanItem.barcode_type}", "${newScanItem.barcode_formats}", "${newScanItem.mpn}", "${newScanItem.model}", "${newScanItem.asin}","${newScanItem.package_quantity}", "${newScanItem.size}", "${newScanItem.length}", "${newScanItem.width}", "${newScanItem.height}", "${newScanItem.weight}", "${newScanItem.description}", "${newScanItem.image}", "${newScanItem.points}", "${newScanItem.status}");');
    });
    newScanItem.id = id;
    print(
        'ScanItem added: ${newScanItem.barcode_number} ${newScanItem.barcode_type}');
    return newScanItem;
  }
}
