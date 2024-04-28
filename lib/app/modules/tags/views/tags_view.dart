import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tags_controller.dart';

class TagsView extends GetView<TagsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<TagsController>( // specify type as Controller
        init: TagsController(), // intialize with the Controller
        builder: (value) => Stack(
          children: <Widget>[

            Positioned(
              top: 0,
              child: CustomPaint(
                painter: PathPainter(controller.path),
              ),
            ),
            Positioned(
              top: controller.calculate(controller.animation.value).dy,
              left: controller.calculate(controller.animation.value).dx,
              child: Container(
                child: Text('dfdfdfdff'),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
