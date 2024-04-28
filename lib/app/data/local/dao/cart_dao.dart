import 'package:graviitee/app/data/local/models/produit.dart';

import '../database/db.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';


class CartDatabaseHelper {


  DB database = DB();
  String nameTable = 'cart';
  String colId = 'id';


  CartDatabaseHelper._createInstance();
  static  CartDatabaseHelper _databaseHelper = CartDatabaseHelper._createInstance();

  factory CartDatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = CartDatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database.database;
    var result = await db.query(nameTable);
    return result;
  }

  Future<int> insert(Product note,) async {
    Database db = await this.database.database;
    var result = await db.insert(nameTable, note.toMap());
    return result;
  }

  Future<int> update(Product note, int id) async {
    var db = await this.database.database;
    var result = await db.update(nameTable, note.toMap(), where: '${colId} = ?', whereArgs: [id]);
    return result;
  }


  Future<List<Product>> getNotsync() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<Product> noteList =[];
    for (int i = 0; i < count; i++) {
      if(noteMapList[i]['issync'] == 'false') noteList.add(Product.fromMap(noteMapList[i]));
    }

    return noteList;
  }

  Future<int> delete(int id) async {
    var db = await this.database.database;
    int result = await db.rawDelete('DELETE FROM $nameTable WHERE $colId = $id');
    return result;
  }

  Future<List<Product>> getList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<Product> noteList = [];
    for (int i = 0; i < count; i++) {
      noteList.add(Product.fromMap(noteMapList[i]));
    }

    return noteList;
  }
}