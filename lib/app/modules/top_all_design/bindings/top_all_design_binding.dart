import 'package:get/get.dart';

import '../controllers/top_all_design_controller.dart';

class TopAllDesignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopAllDesignController>(
      () => TopAllDesignController(),
    );
  }
}
