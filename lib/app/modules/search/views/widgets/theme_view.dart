import 'package:carousel_slider/carousel_slider.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/data/local/models/produit.dart';
import 'package:graviitee/app/modules/detail_design/bindings/detail_design_binding.dart';
import 'package:graviitee/app/modules/detail_design/views/detail_design_view.dart';
import 'package:graviitee/app/modules/detail_designer/bindings/detail_designer_binding.dart';
import 'package:graviitee/app/modules/search/controllers/search_controller.dart';

class ThemeView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() =>controller.listOfThemeCategoryState == 0 ?  Container(
      height: Get.height,
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context,int) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width * 0.7,
                  height: 20.0,
                  child: FadeShimmer(
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.grey[200],
                    height: 90,
                    width: 110,
                    millisecondsDelay: 5000,
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: Get.width,
                  height: 180.0,
                  child: FadeShimmer(
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.grey[200],
                    height: 90,
                    width: 110,
                    millisecondsDelay: 5000,
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: Get.width,
                  height: 10.0,
                  child: FadeShimmer(
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.grey[200],
                    height: 90,
                    width: 110,
                    millisecondsDelay: 5000,
                  ),
                ),
                SizedBox(height: 20,),

              ],
            );
          }
      ),
    ) : Container(
      height: Get.height * 0.8,
      child: ListView.builder(
        itemCount: controller.listOfThemeCategory.length,
        itemBuilder: (context, i) {
          return  controller.listOfThemeCategory[i]["data"].length != 0 ? Container(
            height: 200,
            child: Column(
              children: [
                Text(
                  controller.listOfThemeCategory[i]["category"],
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffee413f),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                SizedBox(
                  height: 10,
                ),
                CarouselSlider.builder(
                  itemCount: controller.listOfThemeCategory[i]["length"],
                  itemBuilder: (BuildContext context, int itemIndex, int izz) =>
                    FlipCard(
                          fill: Fill.fillBack,
                          direction: FlipDirection.HORIZONTAL,
                        controller: controller.listOfThemeCategory[i]["controller"][i][itemIndex],
                        onFlipDone: (status) {
                          if(status) Future.delayed(const Duration(milliseconds: 1500), () {
                            controller.listOfThemeCategory[i]["controller"][i][itemIndex].toggleCard();
                          });
                        },
                          front: Card(
                            elevation: 3,
                            child: Container(
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        topLeft: Radius.circular(5),
                                      ),
                                      child: Image.network(
                                        controller.listOfThemeCategory[i]["data"][itemIndex]['img'],
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Container(
                                            height: 90,
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
                                              height: 90,
                                              child: Center(
                                                  child:
                                                  CircularProgressIndicator(
                                                    color: Color(0xff3fbbce),
                                                  )));
                                        },
                                        fit: BoxFit.cover,
                                        height: 90,
                                        width: 150,
                                      ),
                                    ),
                                    Container(
                                      height: 21.9,
                                      decoration: BoxDecoration(
                                        color: Color(0xffee413f),
                                        borderRadius:
                                        BorderRadius.only(
                                          bottomRight:
                                          Radius.circular(5),
                                          bottomLeft:
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Image.network(
                                            controller.listOfThemeCategory[i]["data"][itemIndex]['flag'],
                                            height: 20,
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Container(
                                            width: Get.width * 0.2,
                                            child: Text(
                                              controller.listOfThemeCategory[i]["data"][itemIndex]['name'],
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  letterSpacing: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          back: Card(
                            elevation: 3,
                            child: InkWell(
                              onTap: () => Get.to(() => DetailDesignView(product: Product.fromMap(controller.listOfThemeCategory[i]['data'][itemIndex]),), binding: DetailDesignBinding()),
                              child: Container(
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: Color(0xffee413f),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                          ),
                                          Icon(
                                            Icons.message_sharp,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            controller.listOfThemeCategory[i]["data"][itemIndex]['likes'].toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            controller.listOfThemeCategory[i]["data"][itemIndex]['comments'].toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          for (int j = 0; j <  controller.listOfThemeCategory[i]["data"][itemIndex]['stock'].toString().length; j++)
                                            Container(
                                              height: 20,
                                              //padding: EdgeInsets.all(2),
                                              margin: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(20))),
                                              child: Center(
                                                  child: Text(
                                                    controller.listOfThemeCategory[i]["data"][itemIndex]['stock'].toString()[j],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),
                                                  )),
                                            ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      InkWell(
                                          onTap: () => Get.to(
                                                  () => DetailDesignView(
                                                product:  Product.fromMap(controller.listOfThemeCategory[i]["data"][itemIndex]),
                                              ),
                                              binding: DetailDesignerBinding()),
                                          child: Icon(
                                            Icons.visibility,
                                            color: Colors.white,
                                          ))
                                    ],
                                  )),
                            ),
                          )
                      ),
                  options: CarouselOptions(
                      height: 120,
                      aspectRatio: 0.3,
                      viewportFraction: 0.33,
                      disableCenter: false,
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 5),
                      enlargeCenterPage: false,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration:
                      Duration(milliseconds: 800),
                      enableInfiniteScroll: true),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.navigate_next,
                      color: Color(0xffee413f),
                      size: 20,
                    ),
                    InkWell(
                      //onTap: ()=> Get.to(()=>AllDesignerView()),
                      child: Text("SEE ALL",
                          style: TextStyle(
                              color: Color(0xffee413f),
                              fontSize: 15,
                              decoration:
                              TextDecoration.underline)),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xffee413f),
                  thickness: 6,
                ),
              ],
            ),
          ) : SizedBox(height: 1,);
        },
      ),
    )

    );
  }
}
