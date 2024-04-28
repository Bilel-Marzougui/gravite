import 'dart:convert';

import 'package:dio/dio.dart' as a;
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graviitee/app/data/local/models/produit.dart';
import 'package:graviitee/app/modules/detail_design/data/detail_design_data.dart';
import '../../../data/local/database/db.dart';
import '../../../data/local/dao/product_dao.dart';
import '../../../data/local/models/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailDesignController extends GetxController with StateMixin,SingleGetTickerProviderMixin {
  final box = GetStorage();
  var hImage = (Get.height * 0.5).obs;
  var hADesign = 30.0.obs;
  var hADesigner = 50.0.obs;
  var isExpended = false.obs;
  var favList = [].obs;
  var followButtonText = true.obs;
  TextEditingController message = TextEditingController();
  ProductDatabaseHelper carteDatabaseHelper = ProductDatabaseHelper();
  var list = [].obs;
  var listLike = [].obs;
  DB db = DB();
  var listOfComment = <Comment>[].obs;
  AnimationController animationController;
  AnimationController animationController1;
  Animation animation;
  Animation animation1;



  void addProduct(Product product) async {
    final _prefs = await SharedPreferences.getInstance();
    int result;
    result = await carteDatabaseHelper.insert(product);
    print("eeeeeeeeeeeeeeeeeeeeeeeee$result");
    if (result != 0) {
      print(product.id);
      favList.value.add(product.id);
      _prefs.setString('list', json.encode(favList));
      getListIdOfFavoriteProduct();
    }
  }

  void deleteProduct(id) async {
    final _prefs = await SharedPreferences.getInstance();
    int result;
    result = await carteDatabaseHelper.delete(int.parse(id));
    print(result);
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$favList");
    favList.remove(id);
    _prefs.setString('list', json.encode(favList));
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$favList");
  }

  getListIdOfFavoriteProduct() async {
    final _prefs = await SharedPreferences.getInstance();
    favList.value = json.decode(_prefs.getString('list'));
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$favList");
  }

  follow(idDesigner) async {
    print(idDesigner);
    print(box.read('customer_id'));
    SmartDialog.showLoading(backDismiss: true);
    await DetailDesignService.getInstance()?.follow(
        a.FormData.fromMap({
          "customer_id": box.read('customer_id'),
          "designer_id": idDesigner,
        }), onSuccess: (data) async {
      if (data == null) {
      } else {
        list.add(idDesigner);
        box.write("followDesigner", list);
        print("dataaaaaaaaaaaaaaaaaaaaaa$data");
        SmartDialog.dismiss();
      }
    }, onError: (e) {});
  }
  like(idDesign) async {
    SmartDialog.showLoading(backDismiss: true);
    await DetailDesignService.getInstance()?.like(
        a.FormData.fromMap({
          "customer_id": box.read('customer_id'),
          "design_id": idDesign,
        }), onSuccess: (data) async {
      if (data == null) {
      } else {
        listLike.add(idDesign);
        box.write("likeDesign", listLike);
        print("dataaaaaaaaaaaaaaaaaaaaaa$data");
        SmartDialog.dismiss();
      }
    }, onError: (e) {});
  }

  unfollow(idDesigner) async {
    print(idDesigner);
    SmartDialog.showLoading(backDismiss: true);
    await DetailDesignService.getInstance()?.unfollow(
        a.FormData.fromMap({
          "customer_id": box.read('customer_id'),
          "designer_id": idDesigner,
        }), onSuccess: (data) async {
      if (data == null) {
      } else {
        list.remove(idDesigner);
        print("dataaaaaaaaaaaaaaaaaaaaaa$data");
        SmartDialog.dismiss();

      }
    }, onError: (e) {});
  }
  unlike(idDesign) async {
    print(idDesign);
    SmartDialog.showLoading(backDismiss: true);
    await DetailDesignService.getInstance()?.unlike(
        a.FormData.fromMap({
          "customer_id": box.read('customer_id'),
          "designer_id": idDesign,
        }), onSuccess: (data) async {
      if (data == null) {
      } else {
        listLike.remove(idDesign);
        print("dataaaaaaaaaaaaaaaaaaaaaa$data");
        SmartDialog.dismiss();

      }
    }, onError: (e) {});
  }
  comment(idDesigner) async {
    print(idDesigner);
    SmartDialog.showLoading(backDismiss: true);
    await DetailDesignService.getInstance()?.comment(
        a.FormData.fromMap({
          "customer_id": box.read('customer_id'),
          "design_id": idDesigner,
          "comment": message.text
        }), onSuccess: (data) async {
      if (data == null) {
      } else {
        list.remove(idDesigner);
        print("dataaaaaaaaaaaaaaaaaaaaaa$data");
        SmartDialog.dismiss();

      }
    }, onError: (e) {});
  }
  getDesignDetail(idDesign) async {
    listOfComment.clear();
    change(listOfComment, status: RxStatus.loading());

    await DetailDesignService.getInstance()?.getDesignDetail( {
      "customer_id": box.read('customer_id'),
      "design_id": idDesign,
    },onSuccess: (data) async{
      try{
        if ( data.data['design']['comments_array'].length == 0 ) {
          change(listOfComment, status: RxStatus.empty());
        } else {
          print("bbbbbbbbbbbbbbbbb${data.data['design']}");
          for (int i=0; i<data.data['design']['comments_array'].length ; i ++) {
            listOfComment.add(Comment.fromJson(data.data['design']['comments_array'][i]));
            change(listOfComment, status: RxStatus.success());
          }

        }
      } catch(e) {

      }

    },onError: (e){});
  }
  @override
  void onInit() async {
    super.onInit();
    animationController =new AnimationController(vsync: this);
    animationController1 =new AnimationController(vsync: this);
    animation = Tween(begin:  0.07, end: 0.36).animate(animationController);
    animation1 = Tween(begin:  0.15, end: 0.8).animate(animationController1);
    getListIdOfFavoriteProduct();
    if(box.read("followDesigner") == null) {
      list.value = [];
    } else {
      list.value = box.read("followDesigner");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  toggle() {
    print('eeeee${animationController.value}');
    if (animationController.value == 1) {
      animationController.animateTo(0,
          duration: Duration(milliseconds: 200), curve: Curves.bounceOut);
    } else {
      animationController.animateTo(1,
          duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
    }
  }
  toggle2() {
    print(animationController1.value);
    if (animationController1.value == 1) {
      animationController1.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.bounceOut);
    } else {
      animationController1.animateTo(1, duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
    }
  }

}
