import 'package:get/get.dart';

import '../controllers/detail_design_controller.dart';

class DetailDesignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailDesignController>(
      () => DetailDesignController(),
    );
  }
}
