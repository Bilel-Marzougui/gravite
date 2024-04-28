import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/modules/detail_designer/bindings/detail_designer_binding.dart';
import 'package:graviitee/app/modules/detail_designer/views/detail_designer_view.dart';
import 'package:graviitee/app/modules/home/controllers/home_controller.dart';

class AllProductComponent extends StatelessWidget {

 final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            homeController.listOfProd.length,
                (index) => Container(
                height: Get.height * 0.3915,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            homeController.listOfProd[index].img,
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
                            fit: BoxFit.contain,
                            height: Get.height * 0.326,
                            width: Get.width,
                          ),
                        ),
                        Positioned(

                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Text(homeController.listOfProd[index].designer.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffee413f),
                                        fontSize: 14,
                                      )),
                                  Spacer(),
                                  Text(homeController.listOfProd[index].price.toString() + " "+ homeController.listOfProd[index].currency,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffee413f),
                                        fontSize: 14,
                                      )),
                                  SizedBox(width: 13,)
                                ],
                              ),
                            )),
                        Positioned(
                            left: 10,
                            top: Get.height*0.25,
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(Icons.favorite,color: Color(0xffee413f),),
                                  SizedBox(width: 4,),
                                  Text(homeController.listOfProd[index].likes.toString(),
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
                            top: Get.height*0.29,
                            left: 10,

                            child: Container(
                              width: Get.width,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Icon(Icons.comment,color: Color(0xffee413f),),
                                  SizedBox(width: 4,),
                                  Text(homeController.listOfProd[index].comments.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffee413f),
                                        fontSize: 14,
                                      )),
                                  Spacer(),
                                  for (int i = 0;
                                  i <
                                      homeController
                                          .listOfProd[index]
                                          .stock
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
                                              Radius.circular(20))),
                                      child: Center(
                                          child: Text(
                                            homeController.listOfProd[index].stock.toString()[i],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )),
                                    ),
                                  SizedBox(width: 20,)
                                ],
                              ),
                            )),
                        Positioned(
                            left: Get.width*0.9,
                            top: Get.height*0.29,
                            child: Container(
                              color: Colors.transparent,
                              child:Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                ],
                              ),
                            )),

                      ],
                    ),
                    Container(
                      height: Get.height * 0.065,
                      decoration: BoxDecoration(
                        color: Color(0xffee413f),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 6,
                          ),
                          Image.network(
                            homeController.listOfProd[index].flag,
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              homeController.listOfProd[index].designer.toUpperCase(),
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
                            onTap: () =>
                                Get.to(() => DetailDesignerView(),binding: DetailDesignerBinding()),
                            child: Text("MORE DESIGNS",
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
    );
  }
}
