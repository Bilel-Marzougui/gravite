import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/component/all_product_component/all_product_component.dart';
import 'package:graviitee/app/component/country/country.dart' as country;

import '../controllers/top_all_design_controller.dart';

class TopAllDesignView extends GetView<TopAllDesignController> {
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
        actions: [
          Icon(
            Icons.search,
            size: 30,
          ),
          SizedBox(
            width: 11,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30,
          ),
          SizedBox(
            width: 7,
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.grey[200],
            height: 50,
            width: Get.width,
            child: Obx(() => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.allState.value = true;
                        controller.nameState.value = false;
                        controller.countryState.value = false;
                        controller.tagState.value = false;
                      },
                      child: Container(
                        width: 120,
                        height: 20,
                        decoration: BoxDecoration(
                            color: controller.allState.value
                                ? Color(0xffee413f)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Center(
                            child: Text(
                          "ALL TOP DESIGNS",
                          style: TextStyle(
                              fontSize: 14,
                              color: controller.allState.value
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                      onTap: () {
                        controller.allState.value = false;
                        controller.nameState.value = true;
                        controller.countryState.value = false;
                        controller.tagState.value = false;
                      },
                      child: Container(
                        width: 70,
                        height: 20,
                        decoration: BoxDecoration(
                            color: controller.nameState.value
                                ? Color(0xffee413f)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Center(
                          child: Text(
                            "THEME",
                            style: TextStyle(
                                fontSize: 14,
                                color: controller.nameState.value
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                      onTap: () {
                        controller.allState.value = false;
                        controller.nameState.value = false;
                        controller.countryState.value = true;
                        controller.tagState.value = false;
                      },
                      child: Container(
                        width: 80,
                        height: 20,
                        decoration: BoxDecoration(
                            color: controller.countryState.value
                                ? Color(0xffee413f)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Center(
                          child: Text(
                            "COUNTRY",
                            style: TextStyle(
                                fontSize: 14,
                                color: controller.countryState.value
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                      onTap: () {
                        controller.allState.value = false;
                        controller.nameState.value = false;
                        controller.countryState.value = false;
                        controller.tagState.value = true;
                      },
                      child: Container(
                        width: 40,
                        height: 20,
                        decoration: BoxDecoration(
                            color: controller.tagState.value
                                ? Color(0xffee413f)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Center(
                          child: Text(
                            "TAG",
                            style: TextStyle(
                                fontSize: 14,
                                color: controller.tagState.value
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
          Container(
            color: Colors.grey[300],
            child: Obx(
              () => controller.countryState.value
                  ? country.Country()
                  : SizedBox(
                      height: 0.1,
                    ),
            ),
          ),
          AllProductComponent()
        ],
      ),
    );
  }
}
