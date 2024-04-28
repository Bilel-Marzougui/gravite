import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/constants/strings/string.dart';
import 'package:graviitee/app/data/local/models/produit.dart';
import 'package:graviitee/app/modules/ar_try/data/home.dart';
import 'package:graviitee/app/modules/detail_design/controllers/detail_design_controller.dart';
import 'package:graviitee/app/modules/home/controllers/home_controller.dart';
import 'package:graviitee/main.dart';

import '../controllers/try_design_controller.dart';

class TryDesignView extends GetView<TryDesignController> {
  Product product;
  TryDesignView({this.product});
  HomeController homeController = Get.find();
  DetailDesignController detailDesignController = Get.find<DetailDesignController>();
  @override
  Widget build(BuildContext context) {
    controller.prod.value = product;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Container(
            color: Color(0xff3fbbce),
            child: Image.asset(
              "assets/logo.png",
              height: 80,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
              onPressed: () => controller.showDialogShop(product),
            ),
            SizedBox(
              width: 7,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 30,
              ),
              onPressed: () => controller.share(),
            ),
            SizedBox(
              width: 7,
            ),
           Obx(()=> IconButton(
              icon: Icon(
                Icons.favorite,
                size: 30,
                color: detailDesignController.favList.contains(product.id) ==
                    true
                    ? Colors.red
                    : Colors.white,
              ),
              onPressed: () => detailDesignController.favList.contains(product.id) == true
                  ? detailDesignController.deleteProduct(product.id)
                  : detailDesignController.addProduct(product),
            )),
            SizedBox(
              width: 7,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: Get.height * 0.77,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        RepaintBoundary(
                          key: controller.globalKey,
                          child: Stack(
                            children: [
                              Obx(() => ClipRRect(
                                    child: Image.asset(
                                      "assets/short/${controller.numShort}_${controller.colorShort}_${controller.typeShort}.png",
                                      fit: BoxFit.contain,
                                      height: Get.height * 0.63,
                                      width: Get.width,
                                    ),
                                  )),
                              Obx(() => Positioned(
                                    top: Get.height * 0.13,
                                    right: 0,
                                    left: 0,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Image.network(
                                        controller.prod.value.img,
                                        fit: BoxFit.contain,
                                        height: 150,
                                        width: 120,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Positioned(
                            child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(top: 10),
                              child: Row(
                            children: [
                              for (int i = 0;
                                  i <
                                      controller.prod.value.stock
                                          .toString()
                                          .length;
                                  i++)
                                Container(
                                  height: 20,
                                  //padding: EdgeInsets.all(2),
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Center(
                                      child: Text(
                                    controller.prod.value.stock.toString()[i],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )),
                                ),
                              Spacer(),
                              Text(
                                "${controller.prod.value.price} ${controller.prod.value.currency}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffee413f),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        )),
                        Positioned(
                            bottom: 4,
                            width: Get.width,
                            child: Container(
                              height: 75,
                              color: Colors.transparent,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: List.generate(
                                      homeController.listOfProd.length,
                                      (index) => Container(
                                            padding: EdgeInsets.all(7),
                                            margin: EdgeInsets.all(2),
                                            height: 75,
                                            width: 60,
                                            color: Colors.white,
                                            child: InkWell(
                                              onTap: () {
                                                controller.prod.value =
                                                    homeController
                                                        .listOfProd[index];
                                              },
                                              child: ClipRRect(
                                                child: Image.network(
                                                  homeController
                                                      .listOfProd[index].img,
                                                  fit: BoxFit.contain,
                                                  height: 75,
                                                  width: 60,
                                                ),
                                              ),
                                            ),
                                          )),
                                ),
                              ),
                            ))
                      ],
                    ),
                    Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                          kShirtLinks.length,
                          (index) => InkWell(
                            onTap: () {
                              print(index);
                              switch (index) {
                                case 0:
                                  controller.numShort.value = "2_long";
                                  controller.typeShort.value = "round";
                                  break;
                                case 1:
                                  controller.numShort.value = "2_long";
                                  controller.typeShort.value = "v";
                                  break;
                                case 2:
                                  controller.numShort.value = "1_short";
                                  controller.typeShort.value = "round";
                                  break;
                                case 3:
                                  controller.numShort.value = "1_short";
                                  controller.typeShort.value = "v";
                                  break;
                              }

                              for (int i = 0;
                                  i < controller.listOfCol.length;
                                  i++) {
                                if (i == index)
                                  controller.listOfCol[i] =
                                      controller.color.value[800];
                                else
                                  controller.listOfCol[i] =
                                      controller.color.value[200];
                              }
                            },
                            child: ClipRRect(
                              child: Image.asset(
                                kShirtLinks[index],
                                fit: BoxFit.contain,
                                height: Get.height * 0.1,
                                width: Get.width * 0.1,
                                color: controller.listOfCol[index],
                              ),
                            ),
                          ),
                        ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.colorShort.value = "black";
                            for (int i = 0;
                                i < controller.listOfCol.length;
                                i++) {
                              controller.listOfCol[i] = Colors.grey[00];
                            }
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            controller.colorShort.value = "white";

                            controller.color.value = Colors.grey[200];
                            controller.colorImg.value = Colors.grey[200];
                            for (int i = 0;
                                i < controller.listOfCol.length;
                                i++) {
                              controller.listOfCol[i] = Colors.grey[200];
                            }
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            controller.colorShort.value = "gray";

                            controller.color.value = Colors.grey;
                            controller.colorImg.value = Colors.grey;
                            for (int i = 0;
                                i < controller.listOfCol.length;
                                i++) {
                              controller.listOfCol[i] = Colors.grey[400];
                            }
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xff3fbbce),
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedIconTheme: IconThemeData(size: 35),
            unselectedIconTheme: IconThemeData(size: 35, color: Colors.white),
            selectedLabelStyle: TextStyle(fontSize: 15, color: Colors.white),
            unselectedLabelStyle: TextStyle(fontSize: 15, color: Colors.white),
            elevation: 0,
            onTap: (val) {
              switch (val) {
                case 0:
                  controller.capturePng();
                  break;
                case 1:
                  Get.to(
                          () => HomePage(cameras,product.img,"assets/short/${controller.numShort}_${controller.colorShort}_${controller.typeShort}.png"));
                  break;
              }
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.save),
                label: 'Save',
                backgroundColor: Color(0xff3fbbce),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_rounded),
                label: 'Try it ar',
                backgroundColor: Color(0xff3fbbce),
              ),

            ],
            currentIndex: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
          ),
        );
  }
}
