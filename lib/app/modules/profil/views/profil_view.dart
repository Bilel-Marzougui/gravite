import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/constants/strings/string.dart';
import 'package:graviitee/app/modules/cart/bindings/cart_binding.dart';
import 'package:graviitee/app/modules/cart/views/cart_view.dart';
import 'package:graviitee/app/modules/favorite/bindings/favorite_binding.dart';
import 'package:graviitee/app/modules/favorite/views/favorite_view.dart';
import 'package:graviitee/app/widgets/bottom_navigation.dart';

import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
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
              height: Get.height * 0.67,
              child: GridView.builder(
                itemCount: kProfile.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      switch(kProfile[index]) {
                        case "MY CART" : Get.to(() => CartView(),binding: CartBinding()); break;
                        case "MY FAVORITE" : Get.to(() => FavoriteView(),binding: FavoriteBinding());break;
                      }
                    },
                    child: Card(
                      elevation: 3,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Icon(
                              KIconProfil[index],
                              size: 36,
                              color: Color(0xff3fbbce),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Text(
                              kProfile[index],
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation());
  }
}
