import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/modules/detail_designer/views/detail_designer_view.dart';
import 'package:graviitee/app/modules/home/controllers/home_controller.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart';

import '../controllers/all_designer_controller.dart';

class AllDesignerView extends GetView<AllDesignerController> {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
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
          )
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
                      },
                      child: Container(
                        width: 110,
                        height: 20,
                        decoration: BoxDecoration(
                            color: controller.allState.value
                                ? Color(0xff3fbbce)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Center(
                            child: Text(
                          "ALL DESIGNERS",
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
                      width: 14,
                    ),
                    InkWell(
                      onTap: () {
                        controller.allState.value = false;
                        controller.nameState.value = true;
                        controller.countryState.value = false;
                      },
                      child: Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                            color: controller.nameState.value
                                ? Color(0xff3fbbce)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Center(
                          child: Text(
                            "NAME",
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
                      width: 14,
                    ),
                    InkWell(
                      onTap: () {
                        controller.allState.value = false;
                        controller.nameState.value = false;
                        controller.countryState.value = true;
                      },
                      child: Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                            color: controller.countryState.value
                                ? Color(0xff3fbbce)
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
                    )
                  ],
                )),
          ),
          Container(
            color: Colors.grey[300],
            child: Obx(
              () => controller.countryState.value
                  ? Container(
                      height: Get.height * 0.3,
                      width: Get.width,
                      margin: EdgeInsets.only(bottom: 10),
                      child: CountryListView(
                        flagWidth: 30,
                        flagHeight: 30,
                        itemTitleStyle: TextStyle(fontSize: 15),
                        itemBuilder: (context, int, country) {
                          return InkWell(
                            onTap: () {
                              print(country.code);
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.3,
                                  ),
                                  Image(
                                    height: 25,
                                    width: 40,
                                    image: new AssetImage(
                                      country.flagUri,
                                      package: 'ola_like_country_picker',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    country.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          );
                        },
                      ))
                  : SizedBox(
                      height: 0.1,
                    ),
            ),
          ),
          Container(
            height: Get.height * 0.8,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  homeController.listOfDesigner.length,
                  (index) => Container(
                      height: Get.height * 0.3915,
                      child: Column(
                        children: [
                          ClipRRect(
                            child: Image.network(
                              homeController.listOfDesigner[index].profilePic,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Container(
                                  height: Get.height * 0.326,
                                  width: Get.width,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
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
                              fit: BoxFit.cover,
                              height: Get.height * 0.326,
                              width: Get.width,
                            ),
                          ),
                          Container(
                            height: Get.height * 0.065,
                            decoration: BoxDecoration(
                              color: Color(0xff3fbbce),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 6,
                                ),
                                Image.network(
                                  homeController.listOfDesigner[index].flag,
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Text(
                                    homeController
                                        .listOfDesigner[index].designer
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                InkWell(
                                  onTap: () => Get.to(() => DetailDesignerView(
                                        designer: homeController
                                            .listOfDesigner[index],
                                      )),
                                  child: Text("SEE DESIGNER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          decoration:
                                              TextDecoration.underline)),
                                ),
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
