import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graviitee/app/modules/home/bindings/home_binding.dart';
import 'package:graviitee/app/modules/home/views/home_view.dart';
import 'package:graviitee/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:graviitee/app/modules/onboarding/views/onboarding_view.dart';

class SplashScreenController extends GetxController {
  final box = GetStorage();
  String img = "assets/logoScreen.png";
  @override
  void onInit() {
    super.onInit();

    goToAuthPages();
  }

  goToAuthPages() async {
    if (box.read('customer_id') == null)
      Timer(Duration(seconds: 3),
          () => Get.off(() => OnboardingView(), binding: OnboardingBinding()));
    else
      Timer(Duration(seconds: 13),
          () => Get.off(() => HomeView(), binding: HomeBinding()));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
