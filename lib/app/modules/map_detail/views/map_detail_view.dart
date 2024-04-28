import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/widgets/bottom_navigation.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/map_detail_controller.dart';

class MapDetailView extends GetView<MapDetailController> {
  @override
  Widget build(BuildContext context) {
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

        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Obx(() => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                 /*   SizedBox(
                      width: 14,
                    ),
                    Container(
                      width: 60,
                      height: 20,
                      child: Center(
                          child: Text(
                        "ALL",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      )),
                    ),*/
                    SizedBox(
                      width: 14,
                    ),
                    InkWell(
                      onTap: () {
                        controller.isDesigner.value = true;
                        controller.designerClick.value = true;
                        controller.isDesign.value = false;
                      },
                      child: Container(
                        width: 130,
                        height: 20,
                        decoration: BoxDecoration(
                            color: controller.designerClick == true
                                ? Color(0xff3fbbce)
                                : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Center(
                          child: Text(
                            "DESIGNERS",
                            style: TextStyle(
                                fontSize: 14,
                                color: controller.designerClick == true
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    InkWell(
                      onTap: () {
                        controller.isDesign.value = true;
                        controller.designerClick.value = false;
                        controller.isDesigner.value = false;
                      },
                      child: Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                            color: controller.isDesign == true
                                ? Color(0xffee413f)
                                : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Center(
                          child: Text(
                            "DESIGNS",
                            style: TextStyle(
                                fontSize: 14,
                                color: controller.isDesign == true
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Color(0xff3fbbce),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: Get.height * 0.65,
                child: Obx(
                  () => FlutterMap(
                    options: MapOptions(
                      center: LatLng(9.1021, 18.2812),
                      zoom: 2.5,
                    ),
                    layers: [
                    TileLayerOptions(
                    urlTemplate:
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
                  ),
                      MarkerLayerOptions(
                          markers: controller.isDesigner.value == true
                              ? controller.markersDesign
                              : controller.markersDesigner)
                    ],
                  ),
                )),
          ],
        ),
        bottomNavigationBar: BottomNavigation());
  }
}
