import 'package:get/get.dart';

import 'package:graviitee/app/modules/ar_try/bindings/try_ar_binding.dart';
import 'package:graviitee/app/modules/ar_try/views/try_ar_view.dart';
import 'package:graviitee/app/modules/tags/bindings/tags_binding.dart';
import 'package:graviitee/app/modules/tags/views/tags_view.dart';
import 'package:graviitee/app/modules/term_of_use/bindings/term_of_use_binding.dart';
import 'package:graviitee/app/modules/term_of_use/views/term_of_use_view.dart';

import '../modules/all_designer/bindings/all_designer_binding.dart';
import '../modules/all_designer/views/all_designer_view.dart';
import '../modules/all_news/bindings/all_news_binding.dart';
import '../modules/all_news/views/all_news_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/detail_design/bindings/detail_design_binding.dart';
import '../modules/detail_design/views/detail_design_view.dart';
import '../modules/detail_designer/bindings/detail_designer_binding.dart';
import '../modules/detail_designer/views/detail_designer_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/map_detail/bindings/map_detail_binding.dart';
import '../modules/map_detail/views/map_detail_view.dart';
import '../modules/media_designer/bindings/media_designer_binding.dart';
import '../modules/media_designer/views/media_designer_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/top_all_design/bindings/top_all_design_binding.dart';
import '../modules/top_all_design/views/top_all_design_view.dart';
import '../modules/try_design/bindings/try_design_binding.dart';
import '../modules/try_design/views/try_design_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ALL_DESIGNER,
      page: () => AllDesignerView(),
      binding: AllDesignerBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_DESIGNER,
      page: () => DetailDesignerView(),
      binding: DetailDesignerBinding(),
    ),
    GetPage(
      name: _Paths.MEDIA_DESIGNER,
      page: () => MediaDesignerView(),
      binding: MediaDesignerBinding(),
    ),
    GetPage(
      name: _Paths.TOP_ALL_DESIGN,
      page: () => TopAllDesignView(),
      binding: TopAllDesignBinding(),
    ),
    GetPage(
      name: _Paths.TRY_AR,
      page: () => TryARView(),
      binding: TryARBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_DESIGN,
      page: () => DetailDesignView(),
      binding: DetailDesignBinding(),
    ),
    GetPage(
      name: _Paths.TRY_DESIGN,
      page: () => TryDesignView(),
      binding: TryDesignBinding(),
    ),
    GetPage(
      name: _Paths.MAP_DETAIL,
      page: () => MapDetailView(),
      binding: MapDetailBinding(),
    ),
    GetPage(
      name: _Paths.ALL_NEWS,
      page: () => AllNewsView(),
      binding: AllNewsBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.TERM_OF_USE,
      page: () => TermOfUseView(),
      binding: TermOfUseBinding(),
    ),
    GetPage(
      name: _Paths.TAGS,
      page: () => TagsView(),
      binding: TagsBinding(),
    ),
  ];
}
