import 'package:get/get.dart';

import '../controllers/detail_designer_controller.dart';

class DetailDesignerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailDesignerController>(
      () => DetailDesignerController(),
    );
  }
}
