import 'package:get/get.dart';

import '../controllers/all_news_controller.dart';

class AllNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllNewsController>(
      () => AllNewsController(),
    );
  }
}
