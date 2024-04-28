import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/modules/home/controllers/home_controller.dart';
import 'package:graviitee/app/widgets/bottom_navigation.dart';

import '../controllers/all_news_controller.dart';

class AllNewsView extends GetView<AllNewsController> {
  HomeController homeController = Get.find<HomeController>();
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
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 60,
                  height: 20,
                  child: Center(
                      child: Text(
                    "ALL",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  )),
                ),
                SizedBox(
                  width: 14,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 130,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Color(0xff82aeb2),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Center(
                      child: Text(
                        "ABOUT POST",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 130,
                    height: 20,
                    decoration: BoxDecoration(
                        //color:  Color(0xff3fbbce),
                        // borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                    child: Center(
                      child: Text(
                        "DESIGNERS",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: Get.height * 0.72,
              child: ListView.builder(
                  itemCount: homeController.listOfNews.length,
                  itemBuilder: (context, itemIndex) {
                    return Card(
                      elevation: 2,
                      child: Container(
                        height: 150,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              child: Image.network(
                                homeController.listOfNews[itemIndex].img,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Container(
                                    height: 150,
                                    width: 120,
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
                                      height: 150,
                                      width: 120,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        color: Color(0xff3fbbce),
                                      )));
                                },
                                fit: BoxFit.cover,
                                height: 150,
                                width: 120,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  homeController.listOfNews[itemIndex].title,
                                  style: TextStyle(
                                      color: Color(0xff82aeb2),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 118,
                                  width: Get.width * 0.57,
                                  child: SingleChildScrollView(
                                      child: RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.justify,
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Color(0xff82aeb2)),
                                              children: [
                                                TextSpan(
                                                  text: homeController
                                                      .listOfNews[itemIndex]
                                                      .content,
                                                )
                                              ]))),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              height: 150,
                              width: 17,
                              color: Color(0xff82aeb2),
                              child: Center(
                                  child: Icon(
                                Icons.navigate_next_outlined,
                                color: Colors.white,
                                size: 15,
                              )),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation());
  }
}
