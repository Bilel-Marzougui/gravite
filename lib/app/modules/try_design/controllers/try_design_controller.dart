import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart' as a;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graviitee/app/data/local/dao/cart_dao.dart';
import 'package:graviitee/app/data/local/database/db.dart';
import 'package:graviitee/app/data/local/models/produit.dart';
import 'package:graviitee/app/modules/try_design/data/try_design_data.dart';
import 'package:path_provider/path_provider.dart';

class TryDesignController extends GetxController {
  final box = GetStorage();
  var colorImg = Colors.grey.obs;
  var color = Colors.grey.obs;
  var imageSrc = "assets/2_long_white_v.png".obs;
  var isClicked = false;
  var numShort = "1_short".obs;
  var colorShort = "gray".obs;
  var typeShort = "v".obs;
  DB db = DB();
  Rx<Product> prod = Product.withoutname().obs;
  CartDatabaseHelper cartDatabaseHelper = CartDatabaseHelper();
  var listOfCol = [
    Colors.grey[200],
    Colors.grey[800],
    Colors.grey[200],
    Colors.grey[200]
  ].obs;
  GlobalKey globalKey = GlobalKey();

  Future<void> capturePng() async {
    try {
      //extract bytes
      final RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData.buffer.asUint8List();

      //create file
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String fullPath = '$dir/${DateTime.now().millisecond}.png';
      File capturedFile = File(fullPath);
      await capturedFile.writeAsBytes(pngBytes);
      print(capturedFile.path);

      await GallerySaver.saveImage(capturedFile.path).then((value) {});
    } catch (e) {
      print(e);
    }
  }

  showDialogShop(product) {
    Get.defaultDialog(
        title: "",
        content: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "14 \$",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width * 0.8,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    "Add to cart",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => addProduct(product),
                  color: Colors.orange,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.3,
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          "Share",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () => share(),
                        color: Colors.black,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    SizedBox(
                      width: Get.width * 0.4,
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          "Save on MyGrav",
                          style: TextStyle(fontSize: 16),
                        ),
                        //onPressed: () => saveOnMyGrave(idDesign),
                        color: Colors.black,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width * 0.6,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  color: Color(0xff3fbbce),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.grey,
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> share() async {
    SmartDialog.showLoading(backDismiss: true);

    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
    SmartDialog.dismiss();
  }

  addToFavorites(idDesign) async {
    print(idDesign);
    print(box.read('customer_id'));
    print(box.read('token'));
    SmartDialog.showLoading(backDismiss: true);
    try {
      a.Dio dio = new a.Dio();
      //dio.options.contentType = ContentType("application","x-www-form-urlencoded") as String;
      dio.options.headers[HttpHeaders.authorizationHeader] ="Bearer f99851a2a46be5d4887c25ed5b6ea9bc";
      var response = await dio.post('http://graviitee.net/dev/mobileapiv2/map/designs/',data: a.FormData.fromMap({
        "customer_id": box.read('customer_id'),
      } ),
      );
      print(response);
    } catch (e) {
      SmartDialog.dismiss();
      print(e);
    }
  }

  saveOnMyGrave(idDesign) async {
    print(idDesign);
    print(box.read('customer_id'));
    SmartDialog.showLoading(backDismiss: true);
    await TryDesignService.getInstance()?.saveOnMyGrave(
        a.FormData.fromMap({
          "items_number": "1",
          "s": 0,
          "xl": 0,
          "l": 0,
          "m": 0,
          "xxl": 0,
          "type1": "design",
          "shirt_id": 0,
          "customer_id": box.read('customer_id'),
          "designer_id": idDesign,
        }), onSuccess: (data) async {
      if (data == null) {
      } else {
        print("eeeeeeeeeeeeeeeeeeeee$data");
        SmartDialog.dismiss();
        Get.snackbar("Success", "yup");
      }
    }, onError: (e) {});
  }

  void addProduct(Product product) async {
    SmartDialog.showLoading(backDismiss: true,isLoadingTemp: true);
    int result;
    result = await cartDatabaseHelper.insert(product);
    print("eeeeeeeeeeeeeeeeeeeeeeeee$result");
    if (result != 0) {
      print(product.id);
    }
    SmartDialog.dismiss();
  }
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
