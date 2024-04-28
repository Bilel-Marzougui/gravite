import 'package:get/get.dart';
import 'package:graviitee/app/data/local/dao/cart_dao.dart';
import 'package:graviitee/app/data/local/database/db.dart';
import 'package:graviitee/app/data/local/models/produit.dart';
import 'package:sqflite/sqflite.dart';

class CartController extends GetxController with StateMixin<List<Product>>{

  CartDatabaseHelper carteDatabaseHelper = CartDatabaseHelper() ;
  DB db = DB();
  var listOfProd = [].obs;

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
}
