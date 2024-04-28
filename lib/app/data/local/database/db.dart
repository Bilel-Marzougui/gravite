import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DB extends GetxController {
  String table = 'productTable';
  String h = 'h';
  String w = 'w';
  String x = 'x';
  String y = 'y';
  String r = 'r';
  String id = 'id';
  String name = 'name';
  String stock = 'stock';
  String price = 'price';
  String currency = 'currency';
  String comments = 'comments';
  String likes = 'likes';
  String designerId = 'designer_id';
  String designer = 'designer';
  String designerProfilePic = 'designer_profile_pic';
  String img = 'img';
  String fullPic = 'full_pic';
  String flag = 'flag';
  String designerCoutry = 'designer_coutry';
  String designerCountryCode = 'designer_country_code';
  String designerCountry = 'designer_country';
  String theme = 'theme';
  String tags = "tags";

  static  Database _database ;
  static  DB db = DB._createInstance();

  DB._createInstance();

  factory DB() {
    if (db == null) {
      db = DB._createInstance();
    }
    return db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  @override
  void onInit() async {
    super.onInit();
    if (_database == null) {
      _database = await initializeDatabase();
    }

  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'grvt.db';
    var fideliteDatabase = await openDatabase(path, version: 2, onCreate: _createDb);
    return fideliteDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $table"
        "($h REAL,"
        "$w REAL, $x INTEGER,$y INTEGER,$r INTEGER, $id TEXT,$name TEXT , $stock INTEGER, $price REAL,$currency TEXT,$comments INTEGER,$likes INTEGER, $designerId TEXT,$designer TEXT,$designerProfilePic TEXT, $img TEXT, $fullPic TEXT,$flag TEXT,$designerCoutry TEXT,$designerCountryCode TEXT, $designerCountry TEXT,$theme TEXT, $tags TEXT  )");
    await db.execute("CREATE TABLE cart"
            "($h REAL,"
            "$w REAL, $x INTEGER,$y INTEGER,$r INTEGER, $id TEXT,$name TEXT , $stock INTEGER, $price REAL,$currency TEXT,$comments INTEGER,$likes INTEGER, $designerId TEXT,$designer TEXT,$designerProfilePic TEXT, $img TEXT, $fullPic TEXT,$flag TEXT,$designerCoutry TEXT,$designerCountryCode TEXT, $designerCountry TEXT,$theme TEXT, $tags TEXT  )");


  }
}