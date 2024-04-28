import 'package:get/get.dart';
import 'package:graviitee/app/modules/all_designer/controllers/all_designer_controller.dart';
import 'package:graviitee/app/modules/all_news/controllers/all_news_controller.dart';
import 'package:graviitee/app/modules/detail_design/controllers/detail_design_controller.dart';
import 'package:graviitee/app/modules/detail_designer/controllers/detail_designer_controller.dart';
import 'package:graviitee/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:graviitee/app/modules/home/controllers/home_controller.dart';
import 'package:graviitee/app/modules/login/controllers/login_controller.dart';
import 'package:graviitee/app/modules/map_detail/controllers/map_detail_controller.dart';
import 'package:graviitee/app/modules/media_designer/controllers/media_designer_controller.dart';
import 'package:graviitee/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:graviitee/app/modules/profil/controllers/profil_controller.dart';
import 'package:graviitee/app/modules/search/controllers/search_controller.dart';
import 'package:graviitee/app/modules/signup/controllers/signup_controller.dart';
import 'package:graviitee/app/modules/top_all_design/controllers/top_all_design_controller.dart';
import 'package:graviitee/app/modules/try_design/controllers/try_design_controller.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController(),);
    Get.lazyPut<HomeController>(() => HomeController(),);
    Get.lazyPut<SearchController>(() => SearchController(),);
    Get.lazyPut<AllDesignerController>(() => AllDesignerController(),);
    Get.lazyPut<AllNewsController>(() => AllNewsController(),);
    Get.lazyPut<TopAllDesignController>(() => TopAllDesignController(),);
    Get.lazyPut<AllNewsController>(() => AllNewsController(),);
    Get.lazyPut<DetailDesignController>(() => DetailDesignController(),);
    Get.lazyPut<DetailDesignerController>(() => DetailDesignerController(),);
    Get.lazyPut<FavoriteController>(() => FavoriteController(),);
    Get.lazyPut<LoginController>(() => LoginController(),);
    Get.lazyPut<MapDetailController>(() => MapDetailController(),);
    Get.lazyPut<OnboardingController>(() => OnboardingController(),);
    Get.lazyPut<MediaDesignerController>(() => MediaDesignerController(),);
    Get.lazyPut<ProfilController>(() => ProfilController(),);
    Get.lazyPut<SignupController>(() => SignupController(),);
    Get.lazyPut<TopAllDesignController>(() => TopAllDesignController(),);
    Get.lazyPut<TryDesignController>(() => TryDesignController(),);
  }
}
