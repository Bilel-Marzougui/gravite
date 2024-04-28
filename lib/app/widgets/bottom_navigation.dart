import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/modules/home/bindings/home_binding.dart';
import 'package:graviitee/app/modules/home/views/home_view.dart';
import 'package:graviitee/app/modules/profil/views/profil_view.dart';
import 'package:graviitee/app/modules/profil/bindings/profil_binding.dart';
import 'package:graviitee/app/modules/search/bindings/search_binding.dart';
import 'package:graviitee/app/modules/search/views/search_view.dart';

Widget BottomNavigation() {

  return Container(
    color: Color(0xff3fbbce),
    height: 70,
    child: BottomNavigationBar(
      backgroundColor: Color(0xff3fbbce) ,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedIconTheme: IconThemeData(size: 35,color: Colors.white),
      unselectedIconTheme: IconThemeData(size: 35,color: Colors.white),
      selectedLabelStyle: TextStyle(fontSize: 15,color: Colors.white),
      unselectedLabelStyle: TextStyle(fontSize: 15,color: Colors.white),
      unselectedItemColor:  Colors.white,
      elevation: 0,
      onTap: (val) {
        switch (val) {
          case 2:
            Get.to(() => ProfilView(),binding: ProfilBinding());
            break;
          case 0:
            Get.to(() => HomeView(),binding: HomeBinding());
            break;
          case 1:
            Get.to(() => SearchView(),binding: SearchBinding());
            break;
        }
      },
      items: const <BottomNavigationBarItem>[

        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Color(0xff3fbbce),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
          backgroundColor: Color(0xff3fbbce),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.perm_identity),
          label: 'Me',
          backgroundColor: Color(0xff3fbbce),
        ),
      ],
      currentIndex: 2,
      selectedItemColor: Colors.white,
    ),
  );
}