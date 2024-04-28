import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/modules/home/bindings/home_binding.dart';
import 'package:graviitee/app/modules/home/views/home_view.dart';
import 'package:graviitee/app/modules/login/views/login_view.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingController extends GetxController {
  final introKey = GlobalKey<IntroductionScreenState>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }
  void onIntroEnd(context) {
   Get.to(()=>LoginView());
  }
  Widget buildFullscrenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }
  Widget buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width,height: 175.0);
  }


  final pageDecoration = const PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    bodyTextStyle: TextStyle(fontSize: 19.0),
    descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    pageColor: Colors.white,
    imagePadding: EdgeInsets.zero,
  );

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
