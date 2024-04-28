import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/modules/search/views/widgets/theme_view.dart';
import 'package:graviitee/app/widgets/bottom_navigation.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
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
        body: Container(
          height: Get.height * 0.77,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              /*  Container(
                  color: Colors.grey[200],
                  height: 50,
                  width: Get.width,
                  child: Obx(() => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.isAll.value = true;
                              controller.isTheme.value = false;
                              controller.isTag.value = false;
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              height: 25,
                              decoration: BoxDecoration(
                                  color: controller.isAll.value == true
                                      ? Color(0xffee413f)
                                      : Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Center(
                                  child: Text(
                                "ALL TOP DESIGNS",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: controller.isAll.value == true
                                        ? Colors.white
                                        : Colors.black),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          InkWell(
                            onTap: () {
                              controller.isAll.value = false;
                              controller.isTheme.value = true;
                              controller.isTag.value = false;
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: controller.isTheme.value == true
                                      ? Color(0xffee413f)
                                      : Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Text(
                                "THEME",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: controller.isTheme.value == true
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          InkWell(
                            onTap: () {
                              controller.isAll.value = false;
                              controller.isTheme.value = false;
                              controller.isTag.value = true;
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: controller.isTag.value == true
                                      ? Color(0xffee413f)
                                      : Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Text(
                                "TAG",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: controller.isTag.value == true
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),*/
                SizedBox(
                  height: 10,
                ),
                ThemeView()
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigation());
  }
}
