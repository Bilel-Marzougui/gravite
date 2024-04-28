import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/constants/strings/string.dart';
import 'package:graviitee/app/modules/all_designer/views/widgets/social_icon.dart';
import 'package:graviitee/app/modules/detail_design/controllers/detail_design_controller.dart';
import 'package:graviitee/app/modules/media_designer/views/media_designer_view.dart';
import 'package:graviitee/app/modules/try_design/controllers/try_design_controller.dart';

import '../../../data/local/models/designer.dart';
import '../controllers/detail_designer_controller.dart';

class DetailDesignerView extends GetView<DetailDesignerController> {
  Designer designer;

  DetailDesignerView({this.designer});
  DetailDesignController designController = Get.put(DetailDesignController());
  DetailDesignerController detailDesignerController = Get.put(DetailDesignerController());
  @override
  Widget build(BuildContext context) {
    detailDesignerController.goToDesign(designer.id);

    TryDesignController tryDesignController = Get.put(TryDesignController());

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () =>
                  Get.to(() => MediaDesignerView(img: designer.profilePic)),
              child: Container(
                height: Get.height * 0.4,
                color: Color(0xff3fbbce),
                child: ClipRRect(
                  child: Image.network(
                    designer.profilePic,
                    fit: BoxFit.cover,
                    height: Get.height * 0.4,
                    width: Get.width,
                  ),
                ),
              ),
            ),
            Obx(() => Container(
                  padding: EdgeInsets.all(12),
                  height: controller.reseau.length != 0
                      ? Get.height * 0.2
                      : Get.height * 0.14,
                  color: Color(0xff3fbbce),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        designer.flag,
                        height: 30,
                        width: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              designer.designer.toUpperCase(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 17,
                                  letterSpacing: 1.5),
                            ),
                            Obx(
                              () => controller.reseau.length != 0
                                  ? SizedBox(
                                      height: 15,
                                    )
                                  : SizedBox(),
                            ),
                            Obx(
                              () => controller.reseau.length != 0
                                  ? Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                          controller.reseau['facebook'] != null
                                              ? SocialMediaIconBtn(
                                                  icon: kSocialIcons[0],
                                                  socialLink: controller
                                                      .reseau['facebook'],
                                                )
                                              : SizedBox(),
                                          controller.reseau['instagram'] != null
                                              ? SocialMediaIconBtn(
                                                  icon: kSocialIcons[1],
                                                  socialLink: controller
                                                      .reseau['facebook'],
                                                )
                                              : SizedBox(),
                                          controller.reseau['tumblr'] != null
                                              ? SocialMediaIconBtn(
                                                  icon: kSocialIcons[3],
                                                  socialLink: controller
                                                      .reseau['facebook'],
                                                )
                                              : SizedBox(),
                                          controller.reseau['flickr'] != null
                                              ? SocialMediaIconBtn(
                                                  icon: kSocialIcons[9],
                                                  socialLink: controller
                                                      .reseau['facebook'],
                                                )
                                              : SizedBox(),
                                          controller.reseau['linkedin'] != null
                                              ? SocialMediaIconBtn(
                                                  icon: kSocialIcons[2],
                                                  socialLink: controller
                                                      .reseau['facebook'],
                                                )
                                              : SizedBox(),
                                          controller.reseau['twitter'] != null
                                              ? SocialMediaIconBtn(
                                                  icon: kSocialIcons[6],
                                                  socialLink: controller
                                                      .reseau['facebook'],
                                                )
                                              : SizedBox(),
                                          controller.reseau['youtube'] != null
                                              ? SocialMediaIconBtn(
                                                  icon: kSocialIcons[4],
                                                  socialLink: controller
                                                      .reseau['facebook'],
                                                )
                                              : SizedBox(),
                                        ])
                                  : SizedBox(),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: Get.width * 0.8,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.group,
                                    color: Colors.white,
                                    size: 29,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    designer.followers.toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.share_rounded,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    designer.designs.toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () => designController.list
                                                .contains(designer.id) ==
                                            false
                                        ? designController.follow(designer.id)
                                        : designController
                                            .unfollow(designer.id),
                                    child: Container(
                                      width: 70,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Center(
                                        child: Obx(() => Text(
                                              designController.list.contains(
                                                          designer.id) ==
                                                      false
                                                  ? "FOLLOW"
                                                  : "UNFOLLOW",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff3fbbce)),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () => tryDesignController.share(),
                                    child: Container(
                                      width: 70,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Center(
                                          child: Text(
                                        "SHARE",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff3fbbce)),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              height: Get.height * .35,
              child: GetBuilder<DetailDesignerController>(
                init: DetailDesignerController(),
                builder: (controller) => controller.items.length != 0 ? GridView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return new GridTile(
                      child: new Card(
                          elevation: 3,
                          color: Colors.white,
                          child: new Stack(
                            children: [
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.network(
                                    controller.items[index]['img'],
                                    width: Get.width * 0.33,
                                    height: Get.height * 0.23,
                                  ),
                                ),
                              ),
                              Positioned(
                                  child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Text(controller.items[index]['name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffee413f),
                                          fontSize: 14,
                                        )),
                                    Spacer(),
                                    Text(
                                        "${controller.items[index]['price']}\$",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffee413f),
                                          fontSize: 14,
                                        )),
                                    SizedBox(
                                      width: 3,
                                    )
                                  ],
                                ),
                              )),
                              Positioned(
                                  top: Get.height * 0.18,
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: Color(0xffee413f),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                            controller.items[index]['likes']
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffee413f),
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: Get.height * 0.21,
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.comment,
                                          color: Color(0xffee413f),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                            controller.items[index]['comments']
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffee413f),
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  left: Get.width * 0.31,
                                  top: Get.height * 0.205,
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    controller.items[index]
                                                            ["stock"]
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Center(
                                                    child: Text(
                                                  controller.items[index]
                                                          ["stock"]
                                                      .toString()[i],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          )),
                    );
                  },
                  itemCount: controller.items.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                ): Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
