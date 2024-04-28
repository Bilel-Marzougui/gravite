import 'package:get/get.dart';

import '../controllers/media_designer_controller.dart';

class MediaDesignerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MediaDesignerController>(
      () => MediaDesignerController(),
    );
  }
}
