import 'package:get/get.dart';

import '../controllers/all_designer_controller.dart';

class AllDesignerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllDesignerController>(
      () => AllDesignerController(),
    );
  }
}
