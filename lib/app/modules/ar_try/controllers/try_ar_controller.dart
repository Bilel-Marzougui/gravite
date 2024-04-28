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
import 'package:tflite/tflite.dart';

class TryARController extends GetxController {
  List<dynamic> recognitions;
  int imageHeight = 0;
  int imageWidth = 0;
  String model = "";

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


  loadModel() async {
    String res;
    res = await Tflite.loadModel(
        model: "assets/mobilenet_v1_1.0_224.tflite",
        labels: "assets/mobilenet_v1_1.0_224.txt");
    print(res);
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
      recognitions = recognitions;
      imageHeight = imageHeight;
      imageWidth = imageWidth;

  }

}
