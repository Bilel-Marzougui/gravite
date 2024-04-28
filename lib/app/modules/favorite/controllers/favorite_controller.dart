import 'dart:convert';

import 'package:get/get.dart';
import 'package:graviitee/app/data/local/models/produit.dart';
import '../../../data/local/database/db.dart';
import '../../../data/local/dao/product_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteController extends GetxController with StateMixin<List<Product>> {
  //TODO: Implement FavoriteController

  ProductDatabaseHelper carteDatabaseHelper = ProductDatabaseHelper() ;
  DB db = DB();
  var listOfProd = [].obs;
  var favList = [].obs;



  @override
  void onInit() {
    super.onInit();
    updateListProduct();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void updateListProduct() {
    final Future<Database> dbFuture = db.initializeDatabase();
    try{
      dbFuture.then((database) {
        Future<List<Product>> noteListFuture = carteDatabaseHelper.getList();
        noteListFuture.then((noteList) {
          listOfProd.value = noteList;
          if(noteList.isEmpty)  change(listOfProd.value, status: RxStatus.empty());
          else change(listOfProd.value, status: RxStatus.success());
        });
      });

    }catch(e){
      change(null, status: RxStatus.error(e.toString()));
    }

     }
  void deleteProduct(id)async{
    final _prefs = await SharedPreferences.getInstance();
    favList.value = json.decode(_prefs.getString('list'));
    int result;
      result = await carteDatabaseHelper.delete(id);
      print(result);
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$favList");
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$id");
    await favList.remove(id.toString());
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$favList");
    _prefs.setString('list', json.encode(favList));
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$favList");

    updateListProduct();

  }


}
