import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/data/local/models/produit.dart';
import 'package:graviitee/app/modules/search/data/search_data.dart';
import 'dart:developer' as dev;
class SearchController extends GetxController {
  var listOfTheme = [].obs;
  var listOfThemeCategory = [].obs;
  var listOfLengthThemeCategory = [].obs;
  var listOfThemeState = 0.obs;
  var listOfThemeCategoryState = 0.obs;
  var isTheme = true.obs;
  var isTag = false.obs;
  var isAll = false.obs;
  List flipCardController = [];
  @override
  void onInit() {
    super.onInit();
    getAllTheme();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getAllTheme() async {
    listOfTheme.clear();
    listOfThemeCategory.clear();
    listOfThemeState.value = 0;
    listOfThemeCategoryState.value = 0;
    await SearchService.getInstance()?.getAllTheme(
        onSuccess: (data) async {
          if (data == null) {
            listOfThemeState.value = 1;
            listOfThemeCategoryState.value = 1;
          } else {
            print(data.data);
            if (data.data.length == 0) {
              listOfThemeState.value = 1;
              listOfThemeCategoryState.value = 1;
            } else {
              await data.data.values.forEach((value) {
                listOfTheme.add(value);
              });
              dev.log("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${listOfTheme}");
              for (int i = 0; i < listOfTheme.length; i++) {
                await getTheme(listOfTheme[i]['category'], listOfTheme[i]['products_count']);
                listOfThemeState.value = 2;
                listOfThemeCategoryState.value = 2;
              }


            }
          }
        },
        onError: (e) {});
  }
  var l = [].obs;
  getTheme(s, comp) async {
    await SearchService.getInstance()?.getTheme(s, onSuccess: (data) async {
      if (data == null) {
        listOfThemeCategoryState.value = 1;
      } else {

        //flipCardController = [];
        print(data.data);
        if (data.data.length == 0) listOfThemeCategoryState.value = 1;
        else {
          var lb = [];
          for (int i = 1; i < 500; i++) {
            lb.add(FlipCardController());
          }
          flipCardController.add(lb);

          await listOfThemeCategory.add({
              "data":  data.data['items'],
              "length": data.data['items'].length,
              "category": s,
              'controller': flipCardController
            });

          dev.log("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkkkkkkkkkkkkkkkkkkk${listOfThemeCategory[0]['controller']}");
        }
      }
    }, onError: (e) {});
  }
}
