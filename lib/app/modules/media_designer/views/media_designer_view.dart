import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/media_designer_controller.dart';

class MediaDesignerView extends GetView<MediaDesignerController> {
  String img;
  MediaDesignerView({this.img});
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
            height: 80,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt,
                size: 35,
                color: Color(0xff3fbbce),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.video_call,
                size: 35,
                color: Colors.grey[300],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: Get.height * 0.7,
              child: Column(
                children: [
                  ClipRRect(
                    child: Image.network(
                      img,
                      fit: BoxFit.cover,
                      height: Get.height * 0.7,
                      width: Get.width,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
