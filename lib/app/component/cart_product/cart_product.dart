import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/data/local/models/produit.dart';
import 'package:graviitee/app/modules/detail_design/bindings/detail_design_binding.dart';
import 'package:graviitee/app/modules/detail_design/views/detail_design_view.dart';
import 'package:graviitee/app/modules/detail_designer/bindings/detail_designer_binding.dart';

class CartProduct extends StatelessWidget {
  List list;
  Color color;
  List flipCardController = <FlipCardController>[];

  CartProduct(
    this.list,
    this.color,
    this.flipCardController
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  CarouselSlider.builder(
      itemCount: list.length - 1,
      itemBuilder: (BuildContext context, int itemIndex, int i) => FlipCard(
        fill: Fill.fillBack,
        direction: FlipDirection.HORIZONTAL,
        controller: flipCardController[itemIndex] ,
        onFlipDone: (status) {
          if(status) Future.delayed(const Duration(milliseconds: 1300), () {
            flipCardController[itemIndex].toggleCard();
          });
        },
        front: Card(
          elevation: 3,
          child: Container(
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                    ),
                    child: Image.network(
                      list[itemIndex].img,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Container(
                          height: 90,
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
                            height: 90,
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Color(0xff3fbbce),
                            )));
                      },
                      fit: BoxFit.contain,
                      height: 90,
                      width: 150,
                    ),
                  ),
                  Container(
                    height: 21.9,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 6,
                        ),
                        Image.network(
                          list[itemIndex].flag,
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          width: Get.width * 0.2,
                          child: Text(
                            list[itemIndex].name,
                            overflow: TextOverflow.ellipsis,
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
            onTap: () => Get.to(() => DetailDesignView(product: list[itemIndex],), binding: DetailDesignBinding()),
            child: Container(
                width: 110,
                decoration: BoxDecoration(
                  color: color,
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
                          list[itemIndex].likes.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          list[itemIndex].comments.toString(),
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
                        for (int i = 0; i < list[itemIndex].stock.toString().length; i++)
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
                                  list[itemIndex].stock.toString()[i],
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

                  ],
                )),
          ),
        ),
      ),
      options: CarouselOptions(
          pauseAutoPlayOnTouch: true,
          height: 120,
          aspectRatio: 0.3,
          viewportFraction: 0.33,
          disableCenter: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 5),
          enlargeCenterPage: false,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          enableInfiniteScroll: true),
    ));
  }
}
