import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/data/local/models/produit.dart';
import 'package:graviitee/app/modules/ar_try/data/home.dart';
import 'package:graviitee/app/modules/try_design/bindings/try_design_binding.dart';
import 'package:graviitee/app/modules/try_design/controllers/try_design_controller.dart';
import 'package:graviitee/app/modules/try_design/views/try_design_view.dart';
import 'package:graviitee/main.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../controllers/detail_design_controller.dart';

class DetailDesignView extends GetView<DetailDesignController> {
  TryDesignController tryDesignController = Get.put(TryDesignController());
  Product product;

  DetailDesignView({this.product});

  @override
  Widget build(BuildContext context) {
    controller.getDesignDetail(product.id);
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
          Obx(() => FavoriteButton(
                iconColor: Colors.red,
                iconDisabledColor: Colors.white,
                isFavorite:
                    controller.favList.contains(product.id) ? true : false,
                valueChanged: (_isFavorite) {
                  print(_isFavorite);
                  if (_isFavorite == true)
                    controller.addProduct(product);
                  else
                    controller.deleteProduct(product.id);
                },
              )),
          SizedBox(
            width: 11,
          ),
          Icon(
            Icons.share_rounded,
            size: 30,
          ),
          SizedBox(
            width: 7,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
              color: Colors.grey[200],
              child: Container(
                  height: Get.height * 0.665,
                  child: ClipRRect(
                    child: Image.network(
                      product.img,
                      fit: BoxFit.contain,
                      height: Get.height * 0.665,
                      width: Get.width,
                    ),
                  ))),

          AnimatedBuilder(
            animation: controller.animation1,
            child: sheet1(controller.animation1),
            builder: (BuildContext context, Widget child) {//but here its always the same
              return sheet1(controller.animation1); //we would need to modify child here i guess
            },
          ),
          AnimatedBuilder(
            animation: controller.animation,
            child: sheet(controller.animation),
            builder: (BuildContext context, Widget child) {
              //print(animation.value); // height is correct applied
              print((child as DraggableScrollableSheet)
                  .initialChildSize); //but here its always the same
              return sheet(controller
                  .animation); //we would need to modify child here i guess
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Color(0xff3fbbce),
        height: 70,
        child: BottomNavigationBar(
          backgroundColor: Color(0xff3fbbce),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedIconTheme: IconThemeData(size: 35),
          unselectedIconTheme: IconThemeData(size: 35, color: Colors.white),
          selectedLabelStyle: TextStyle(fontSize: 15, color: Colors.white),
          unselectedLabelStyle: TextStyle(fontSize: 15, color: Colors.white),
          elevation: 0,
          onTap: (val) {
            switch (val) {
              case 0:
                Get.to(
                    () => TryDesignView(
                          product: product,
                        ),
                    binding: TryDesignBinding());
                break;
              case 1:
                Get.to(() => HomePage(
                    cameras, product.img, "assets/1_short_black_round.png"));
                break;
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.check),
              label: 'Try it',
              backgroundColor: Color(0xff3fbbce),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_rounded),
              label: 'Try it ar',
              backgroundColor: Color(0xff3fbbce),
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
        ),
      ),
    );
  }

  sheet(Animation animation) {
    return DraggableScrollableSheet(
      initialChildSize: controller.animation.value,
      minChildSize: controller.animation.value,
      maxChildSize: 0.75,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: Container(
                    height: 300,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              controller.toggle();
                            },
                            child: Container(
                              height: 40,
                              color: Color(0xff3fbbce),
                              child: Row(
                                children: [
                                  Text(
                                    "ABOUT DESIGNER",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Spacer(),
                                  Icon(Icons.keyboard_arrow_up_rounded,
                                      color: Colors.white),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(8),
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Image.network(
                                      product.designerProfilePic,
                                      fit: BoxFit.cover,
                                      height: Get.height * 0.15,
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.designer,
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.network(
                                      product.flag,
                                      height: 30,
                                      width: 30,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, left: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 108,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Color(0xff3fbbce),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Center(
                                          child: Text(
                                        "MORE DESIGNES",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                        onTap: () => controller.list.contains(
                                                    product.designerId) ==
                                                false
                                            ? controller
                                                .follow(product.designerId)
                                            : controller
                                                .unfollow(product.designerId),
                                        child: Container(
                                          width: 108,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Color(0xff3fbbce),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Center(
                                            child: Obx(() => Text(
                                                  controller.list.contains(product
                                                              .designerId) ==
                                                          false
                                                      ? "FOLLOW"
                                                      : "UNFOLLOW",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                )),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () => tryDesignController.share(),
                                      child: Container(
                                        width: 108,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Color(0xff3fbbce),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Center(
                                            child: Text(
                                          "SHARE",
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  sheet1(Animation animation) {
    return DraggableScrollableSheet(
      initialChildSize: controller.animation1.value,
      minChildSize:  controller.animation1.value,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: Container(
                    height: 400,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              controller.toggle2();
                            },
                            child: Container(
                              height: 40,
                              color: Color(0xffee413f),
                              child: Row(
                                children: [
                                  Text(
                                    "ABOUT DESIGN",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Spacer(),
                                  Icon(Icons.keyboard_arrow_up_rounded,
                                      color: Colors.white),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                      color: Color(0xffee413f),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  product.price.toString() +
                                      " " +
                                      product.currency,
                                  style: TextStyle(
                                      color: Color(0xffee413f),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Theme",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  product.theme,
                                  style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      for (int i = 0;
                                      i <
                                          product.stock
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
                                                product.stock.toString()[i],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black),
                                              )),
                                        ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Tags",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: Get.width * 0.77,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0;
                                        i < product.tags.length;
                                        i++)
                                          Container(
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color:
                                                Color(0xffee413f),
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        20))),
                                            child: Center(
                                                child: Text(
                                                  product.tags[i]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                )),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () => controller.listLike
                                      .contains(product.id)
                                      ? controller.unlike(product.id)
                                      : controller.like(product.id),
                                  child: controller.listLike
                                      .contains(product.id)
                                      ? Icon(
                                    Icons.favorite,
                                    color: Color(0xffee413f),
                                  )
                                      : Icon(
                                    Icons.favorite,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(product.likes.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffee413f),
                                      fontSize: 14,
                                    )),
                                SizedBox(
                                  width: 24,
                                ),
                                Icon(
                                  Icons.comment,
                                  color: Color(0xffee413f),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(product.comments.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffee413f),
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10, bottom: 10, top: 10),
                                  height: 60,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      10.0)),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor:
                                            Color(0xFFF2F3F5),
                                            hintStyle: TextStyle(
                                              color: Color(0xFF666666),
                                              fontFamily:
                                              'Roboto-Light.ttf',
                                              fontSize: 14,
                                            ),
                                            hintText:
                                            "Write message ...",
                                          ),
                                          controller:
                                          controller.message,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () => controller
                                            .comment(product.id),
                                        child: Icon(
                                          Icons.send,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        backgroundColor:
                                        Color(0xffee413f),
                                        elevation: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          controller.obx(
                                (state) => Container(
                                height: 100,
                                padding: EdgeInsets.all(0),
                                child: Obx(
                                      () => ListView.builder(
                                      itemCount: controller
                                          .listOfComment.length,
                                      itemBuilder: (context, i) {
                                        return ListTile(
                                          leading: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                            Colors.grey[400],
                                            child: Image.network(
                                                controller
                                                    .listOfComment[i]
                                                    .img),
                                          ),
                                          title: Text(
                                            controller
                                                .listOfComment[i].user,
                                            style: TextStyle(
                                                color:
                                                Color(0xff3fbbce),
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            controller.listOfComment[i]
                                                .comment,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          trailing: Text(
                                            controller
                                                .listOfComment[i].date,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        );
                                      }),
                                )),
                            onEmpty: Center(
                                child: Text(
                                  "no comments",
                                  style: TextStyle(color: Colors.black),
                                )),
                            onLoading: SkeletonGridLoader(
                              builder: Container(
                                height: 70,
                                child: ListTile(
                                  leading: CircleAvatar(),
                                  title: Container(
                                    width: 20,
                                    height: 10,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    width: 50,
                                    height: 10,
                                    color: Colors.white,
                                  ),
                                  trailing: Container(
                                    width: 20,
                                    height: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              items: 19,
                              itemsPerRow: 1,
                              period: Duration(seconds: 1),
                              highlightColor: Colors.lightBlue[300],
                              direction: SkeletonDirection.ltr,
                              childAspectRatio: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
