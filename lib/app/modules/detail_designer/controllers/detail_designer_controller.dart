import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graviitee/app/modules/map_detail/data/map_data.dart';

class DetailDesignerController extends GetxController {
  //TODO: Implement DetailDesignerController

  final count = 0.obs;
  var box = GetStorage();
  List items = [].obs;
  var reseau = {}.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  goToDesign( des) async {
    await MapService.getInstance()?.getDetailDesigner(box.read("customer_id"), des,
        onSuccess: (data) async {
          print("zzzzzzzzzzzzzzzzzzzzzzz${data.data}");
          items = data.data['items'];
          reseau.value = data.data['social_networks'];
          print('aaaaaaaaaaaaaaaaaaaaaaaa${reseau['facebookf'].runtimeType}');
          update();
        });
  }
}