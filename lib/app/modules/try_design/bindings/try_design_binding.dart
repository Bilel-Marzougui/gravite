import 'package:get/get.dart';

import '../controllers/try_design_controller.dart';

class TryDesignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TryDesignController>(
      () => TryDesignController(),
    );
  }
}
