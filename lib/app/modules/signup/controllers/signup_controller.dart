import 'package:dio/dio.dart' as a;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graviitee/app/modules/home/views/home_view.dart';
import 'package:graviitee/app/modules/signup/data/signup_data.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
class SignupController extends GetxController {
  final box = GetStorage();
  final formKey = GlobalKey<FormState>();
  var currencies = [
    "designer",
    "personality",
    "brand",
    "ong",
    "sport club",
  ].obs;
  var currentSelectedValue = "designer".obs;
  var isDesigner = 1.obs;
  var isPersonality = 0.obs;
  var isBrand = 0.obs;
  var isOng = 0.obs;
  var isSportClub = 0.obs;

  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final requiredValidator = RequiredValidator(errorText: 'Ce champ est requis');
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Adresse E-mail requis'),
    EmailValidator(errorText: 'enter a valid email address')
  ]);
  final count = 0.obs;

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

  void _showLoading() async {
    await Future.delayed(Duration(seconds: 2));
  }

  signup(context) async {

    if (formKey.currentState.validate()) {

    SmartDialog.showLoading(
        backDismiss: false);
    await SignupService.getInstance()?.signup(
        a.FormData.fromMap({
          "email": email.text,
          "password": password.text,
          "username": name.text,
          "is_designer": isDesigner.value,
          "is_personality": isPersonality.value,
          "is_brand": isBrand.value,
          "is_ong": isOng.value,
          "is_sportclub": isSportClub.value,
        }), onSuccess: (data) async {
      if (data == null) {
      } else {
        print("dataaaaaaaaaaaaaaaaaaaaaa${data.data}");
        if (data.data['status'] == 1) {
          box.write('customer_id', data.data['customer_id']);
          box.write('email', data.data['info']['email']);
          box.write('username', data.data['info']['username']);
          //box.write('token', data.data['info']['token']);
          SmartDialog.dismiss();
          Get.to(() => HomeView());
          Get.snackbar("Success", "Hello ${data.data['info']['username']}",
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Color(0xff3fbbce),
              duration: Duration(seconds: 6));
        } else
          Get.snackbar("Error", "no");
      }
    }, onError: (e) {});
  }}
}
