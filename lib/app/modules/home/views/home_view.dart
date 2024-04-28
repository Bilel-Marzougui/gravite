import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/component/cart_designer/cart_designer.dart';
import 'package:graviitee/app/component/cart_product/cart_product.dart';
import 'package:graviitee/app/component/loader/loader.dart';
import 'package:graviitee/app/component/see_all/see_all.dart';
import 'package:graviitee/app/modules/all_designer/bindings/all_designer_binding.dart';
import 'package:graviitee/app/modules/all_designer/views/all_designer_view.dart';
import 'package:graviitee/app/modules/all_news/bindings/all_news_binding.dart';
import 'package:graviitee/app/modules/all_news/views/all_news_view.dart';
import 'package:graviitee/app/modules/map_detail/bindings/map_detail_binding.dart';
import 'package:graviitee/app/modules/map_detail/views/map_detail_view.dart';
import 'package:graviitee/app/modules/top_all_design/bindings/top_all_design_binding.dart';
import 'package:graviitee/app/modules/top_all_design/views/top_all_design_view.dart';
import 'package:graviitee/app/widgets/bottom_navigation.dart';
import 'package:graviitee/app/widgets/drawer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    RefreshController refreshController =
        RefreshController(initialRefresh: false);
    return ConnectivityScreenWrapper(
      child: SmartRefresher(
        controller: refreshController,
        reverse: true,
        header: WaterDropHeader(),
        onRefresh: () async {
          await controller.getTopDesign();
          await controller.getDesigner();
          await controller.getLastDesign();
          await controller.getNews();
          await refreshController.refreshCompleted();
        },
        onLoading: () async {
          await Future.delayed(Duration(milliseconds: 50));
          refreshController.loadComplete();
        },
        child: DraggableHome(
            headerExpandedHeight: 0.15,
            curvedBodyRadius: 0,
            alwaysShowLeadingAndAction: true,
            drawer: AppDrawer(),
            title: Container(
              color: Color(0xff3fbbce),
              child: Image.asset(
                "assets/logo.png",
                height: 50,
              ),
            ),
            headerWidget: Container(
              color: Color(0xff3fbbce),
              child: Container(
                  height: 10,
                  child: Image.asset(
                    "assets/logo.png",
                    height: 170,
                    width: 100,
                  )),
            ),
            body: [
              SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/alldesigner.png",
                height: 40,
              ),
              SizedBox(
                height: 10,
              ),
              CartDesigner(),
              SeeAll(
                  Color(0xff3fbbce), AllDesignerView(), AllDesignerBinding()),
              Image.asset(
                "assets/topdesign.png",
                height: 40,
              ),
              SizedBox(
                height: 10,
              ),
              controller.obx(
                (state) => CartProduct(state, Color(0xffee413f),controller.flipCardControllerState),
                //onError:(error) => Text("$error"),
                onLoading: Loader(),
                onEmpty: Center(
                    child: Text(
                  "no data",
                  style: TextStyle(color: Colors.black),
                )),
              ),
              SeeAll(
                  Color(0xffee413f), TopAllDesignView(), TopAllDesignBinding()),
              Image.asset(
                "assets/last.png",
                height: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => Container(
                    child: controller.lastDesignState == 0
                        ? Loader()
                        : controller.lastDesignState == 1
                            ? Center(
                                child: Text(
                                "no data",
                                style: TextStyle(color: Colors.black),
                              ))
                            : CartProduct(
                                controller.listOfLastProd, Colors.black,controller.flipCardControllerLast),
                  )),
              SeeAll(Colors.black, TopAllDesignView(), TopAllDesignBinding()),
              Image.asset(
                "assets/map.png",
                height: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                child: Image.network(
                  "http://graviitee.net/dev/media/catalog/product/watermark/default/mapC.jpg",
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Container(
                      height: 200,
                      width: Get.width,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace stackTrace) {
                    return Container(
                        height: 200,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Color(0xff3fbbce),
                        )));
                  },
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              SeeAll(Colors.grey, MapDetailView(), MapDetailBinding()),
              Image.asset(
                "assets/new.png",
                height: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => Container(
                    child: controller.newsState == 0
                        ? FadeShimmer(
                            baseColor: Colors.grey[400],
                            highlightColor: Colors.grey[200],
                            height: 150,
                            width: Get.width,
                            millisecondsDelay: 5000,
                          )
                        : controller.newsState == 1
                            ? Center(
                                child: Text(
                                "no data",
                                style: TextStyle(color: Colors.black),
                              ))
                            : CarouselSlider.builder(
                                itemCount: controller.listOfNews.length,
                                itemBuilder: (BuildContext context,
                                        int itemIndex, int i) =>
                                    Card(
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
                                            controller
                                                .listOfNews[itemIndex].img,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Container(
                                                height: 150,
                                                width: 120,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
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
                                                Object exception,
                                                StackTrace stackTrace) {
                                              return Container(
                                                  height: 150,
                                                  width: 120,
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              controller
                                                  .listOfNews[itemIndex].title,
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
                                                      textAlign:
                                                          TextAlign.justify,
                                                      text: TextSpan(
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff82aeb2)),
                                                          children: [
                                                            TextSpan(
                                                              text: controller
                                                                  .listOfNews[
                                                                      itemIndex]
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
                                ),
                                options: CarouselOptions(
                                    height: 160,
                                    aspectRatio: 0.3,
                                    viewportFraction: 1,
                                    disableCenter: false,
                                    autoPlay: false,
                                    autoPlayInterval: Duration(seconds: 5),
                                    enlargeCenterPage: false,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    enableInfiniteScroll: true),
                              ),
                  )),
              SeeAll(Color(0xff82aeb2), AllNewsView(), AllNewsBinding()),
            ],
            bottomNavigationBar: BottomNavigation()),
      ),
    );
  }
}
