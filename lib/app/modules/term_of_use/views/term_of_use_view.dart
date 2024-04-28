import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graviitee/app/modules/home/bindings/home_binding.dart';
import 'package:graviitee/app/modules/home/views/home_view.dart';

import '../controllers/term_of_use_controller.dart';

class TermOfUseView extends GetView<TermOfUseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Container(
          color: Color(0xff3fbbce),
          child: Image.asset(
            "assets/logo.png",
            height: 90,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(()=> controller.text.value != ""?Column(
            children: [
              HtmlWidget(controller.text.value),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(onPressed: (){
                    Get.to(() => HomeView(),binding: HomeBinding());

                  },child: Text('Accept'),),
                  SizedBox(width: 14,),
                  RaisedButton(onPressed: (){
                    final box = GetStorage();
                    box.remove('customer_id');

                    SystemNavigator.pop();
                  },child: Text('don t accept'),),
                ],
              )
            ],
          ):Center(
            child: CircularProgressIndicator(),
          )) ,
        ),
      ),
    );
  }
}
