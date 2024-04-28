import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/component/loader/loader.dart';
import 'package:graviitee/app/modules/detail_designer/views/detail_designer_view.dart';
import 'package:graviitee/app/modules/home/controllers/home_controller.dart';

class CartDesigner extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        child: controller.designerState == 0
            ? Loader()
            : controller.designerState == 1
                ? Center(
                    child: Text(
                    "no data",
                    style: TextStyle(color: Colors.black),
                  ))
                : Obx(
                    () => CarouselSlider.builder(
                      itemCount: controller.listOfDesigner.length - 1,
                      itemBuilder: (BuildContext context, int itemIndex, int i) =>
                      FlipCard(
                        onFlipDone: (status) {
                          if(status) Future.delayed(const Duration(milliseconds: 2000), () {

                            controller.flipCardController[itemIndex].toggleCard();
                          });
                        },
                        onFlip: () {


                        },
                        controller: controller.flipCardController[itemIndex] ,

                        fill: Fill.fillBack,
                        direction: FlipDirection.HORIZONTAL,
                        // default
                        front: Card(
                          elevation: 3,
                          child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.network(
                                  controller
                                      .listOfDesigner[itemIndex].profilePic,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Container(
                                      height: 90,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object exception, StackTrace stackTrace) {
                                    return Container(
                                        height: 90,
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          color: Color(0xff3fbbce),
                                        )));
                                  },
                                  fit: BoxFit.contain,
                                ),
                              )),
                        ),
                        back: Card(
                          elevation: 3,
                          child: InkWell(
                            onTap: () => Get.to(() => DetailDesignerView(
                                  designer:
                                      controller.listOfDesigner[itemIndex],
                                )),
                            child: Container(
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          controller
                                              .listOfDesigner[itemIndex].flag,
                                          height: 30,
                                          width: 30,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          controller.listOfDesigner[itemIndex]
                                              .designer,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))),
                          ),
                        ),
                      ),
                      options: CarouselOptions(
                          disableCenter: false,
                          pageSnapping: false,
                          pauseAutoPlayOnTouch: true,
                          height: 110,
                          aspectRatio: 0.3,
                          viewportFraction: 0.33,
                          autoPlay: false,
                          autoPlayInterval: Duration(seconds: 5),
                          enlargeCenterPage: false,
                          autoPlayCurve: Curves.bounceIn,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 100),
                          enableInfiniteScroll: true),
                    ),
                  )));
  }
}
