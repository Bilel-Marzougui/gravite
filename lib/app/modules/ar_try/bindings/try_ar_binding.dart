import 'package:get/get.dart';

import '../controllers/try_ar_controller.dart';

class TryARBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TryARController>(
      () => TryARController(),
    );
  }
}
