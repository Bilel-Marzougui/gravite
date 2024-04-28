import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/data/local/models/news.dart';
import 'package:graviitee/app/data/local/models/produit.dart';
import 'package:graviitee/app/modules/home/data/home_data.dart';
import '../../../data/local/models/designer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController
    with SingleGetTickerProviderMixin, StateMixin {
  AnimationController animcontroller;
  List flipCardController = <FlipCardController>[];
  List flipCardControllerState = <FlipCardController>[];
  List flipCardControllerLast = <FlipCardController>[];
  TickerProvider vsync;
  var designerState = 0.obs;
  var lastDesignState = 0.obs;
  var newsState = 0.obs;
  var listOfProd = <Product>[].obs;
  var listOfLastProd = <Product>[].obs;
  RxList<Designer> listOfDesigner = <Designer>[].obs;
  var listOfNews = <News>[].obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    super.onInit();
    vsync = this;
    getNews();
    await getTopDesign();
    for (int i = 1; i < state.length; i++) {
      flipCardControllerState.add(FlipCardController());
    }
    await getDesigner();
    for (int i = 1; i < listOfDesigner.length; i++) {
      flipCardController.add(FlipCardController());
    }
    await getLastDesign();
    for (int i = 1; i < state.length; i++) {
      flipCardControllerLast.add(FlipCardController());
    }





  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  getTopDesign() async {
    listOfProd.clear();
    change(listOfProd, status: RxStatus.loading());
    await HomeService.getInstance()?.getTopDesign(
        onSuccess: (data) async {
          if (data == null) {
            change(listOfProd, status: RxStatus.empty());
          } else {
            print(data.data);
            for (int i = 0; i < data.data['items'].length; i++) {
              listOfProd.add(Product.fromMap(data.data['items'][i]));
            }
            print("dsdnbdsbsdvbsn**** ${data.data['items'].length}");
            change(listOfProd, status: RxStatus.success());
          }
        },
        onError: (e) {});
  }

  getDesigner() async {
    listOfDesigner.clear();
    designerState.value = 0;
    await HomeService.getInstance()?.getDesigner(
        onSuccess: (data) async {
          if (data == null) {
            designerState.value = 1;
            print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj${designerState.value}");
          } else {
            print(data.data);
            if (data.data['items'].length == 0)
              designerState.value = 1;

            else {
              print(
                  "dsdnbdsbsdvbsnssssssssssssssss**** ${data.data['items'].length}");
              print("dsdnbdsbsdvbsnssssssssssssssss**** ${data.data['items']}");
              for (int i = 0; i < data.data['items'].length; i++) {
                listOfDesigner.add(Designer.fromJson(data.data['items'][i]));
              }
              designerState.value = 2;
              print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj${designerState.value}");

            }

            // change(listOfDesigner, status: RxStatus.success());
          }
        },
        onError: (e) {});
  }

  getLastDesign() async {
    lastDesignState.value = 0;
    listOfLastProd.clear();
    await HomeService.getInstance()?.getLastDesign(
        onSuccess: (data) async {
          if (data == null) {
            lastDesignState.value = 1;
          } else {
            print(data.data);
            if (data.data['items'].length == 0)
              lastDesignState.value = 1;
            else {
              print("vvvvvvvvv**** ${data.data['items'].length}");
              print("vvvvvvvv**** ${data.data['items']}");
              for (int i = 0; i < data.data['items'].length; i++) {
                listOfLastProd.add(Product.fromMap(data.data['items'][i]));
              }
              lastDesignState.value = 2;
            }

            // change(listOfDesigner, status: RxStatus.success());
          }
        },
        onError: (e) {});
  }

  getNews() async {
    listOfNews.clear();
    newsState.value = 0;
    await HomeService.getInstance()?.getNews(
        onSuccess: (data) async {
          if (data == null) {
            newsState.value = 1;
          } else {
            print(data.data);
            if (data.data['items'].length == 0)
              newsState.value = 1;
            else {
              print("vvvvvvvvv**** ${data.data['items'].length}");
              print("vvvvvvvv**** ${data.data['items']}");
              for (int i = 0; i < data.data['items'].length; i++) {
                listOfNews.add(News.fromJson(data.data['items'][i]));
              }
              newsState.value = 2;
            }

            // change(listOfDesigner, status: RxStatus.success());
          }
        },
        onError: (e) {});
  }
}
