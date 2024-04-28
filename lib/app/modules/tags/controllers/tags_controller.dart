import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/modules/tags/data/tags_data.dart';

class TagsController extends GetxController with GetSingleTickerProviderStateMixin{
  //TODO: Implement TagsController

  List tags = [].obs;

  AnimationController animationController;
  Animation animation;
  Path path;
  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 5000));
    animation = Tween(begin: 0.0,end: 1.0).animate(animationController)
      ..addListener((){
        update();
      });
    animationController.forward();
    path  = drawPath();
    update();
    getTheme();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getTheme() async {
    await TagsService.getInstance()?.tags(onSuccess: (data) async {
      if (data == null) {
  print(data);
      } else {
        print(data.data);
        tags = data.data;
      }
    }, onError: (e) {});
  }
  Path drawPath(){
    Size size = Size(300,700);
    Path path = Path();
    path.moveTo(0, size.height );
   // path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height / 2);
    path.relativeCubicTo(size.width / 2, size.height, size.width / 2, size.height/2, 84, 383);
    update();
    return path;
  }


  Offset calculate(value) {
    PathMetrics pathMetrics = path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    update();
    return pos.position;
  }

}
class PathPainter extends CustomPainter {

  Path path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
