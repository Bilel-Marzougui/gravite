import 'package:get/get.dart';
import 'package:graviitee/app/modules/term_of_use/data/term_data.dart';

class TermOfUseController extends GetxController {
  //TODO: Implement TermOfUseController

  final text = "".obs;
  @override
  void onInit() {
    super.onInit();
    getTheme();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  getTheme() async {
    await TermService.getInstance()?.term( onSuccess: (data) async {
      if (data == null) {

      } else {
        print(data.data);
        text.value = data.data['text'];
      }
    }, onError: (e) {});
  }}
