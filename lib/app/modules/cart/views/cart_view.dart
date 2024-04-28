import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends GetView<CartController> {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: Get.height * 0.86,
            child: controller.obx(
                  (state) => GridView.builder(
                itemCount: state.length,
                itemBuilder: (BuildContext context, int index) {
                  return FlipCard(
                    fill: Fill.fillBack,
                    // Fill the back side of the card to make in the same size as the front.
                    direction: FlipDirection.HORIZONTAL,
                    // default
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
                                  state[index].img,
                                  fit: BoxFit.cover,
                                  height: Get.height * 0.242,
                                  width: Get.width * 0.5,
                                ),
                              ),
                              Container(
                                height: Get.height * 0.05,
                                decoration: BoxDecoration(
                                  color: Color(0xffee413f),
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
                                      state[index].flag,
                                      height: 20,
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Container(
                                      width: Get.width * 0.2,
                                      child: Text(
                                        state[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            letterSpacing: 1.5),
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {

                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.white,
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    state[index].likes.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    state[index].comments.toString(),
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
                                  Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(
                                      (state[index].stock / 10)
                                          .toInt()
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(
                                      (state[index].stock % 10)
                                          .toInt()
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              InkWell(
                                  child: Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ))
                            ],
                          )),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
              ),
              onLoading: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff3fbbce),
                  )),
              onEmpty: Center(
                  child: Text(
                    "no data",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
