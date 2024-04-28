import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'models.dart';

class BndBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;
  final String imgRem;
  final String imgLoc;

  BndBox(this.results, this.previewH, this.previewW, this.screenH, this.screenW,
      this.model, this.imgRem, this.imgLoc);
  double x1 = 100.0, x2 = 200.0, y1 = 100.0,
      y2 = 200.0, x1Prev = 100.0, x2Prev = 200.0, y1Prev = 100.0,
      y2Prev = 100.0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBoxes() {
      return results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var scaleW, scaleH, x, y, w, h;

        if (screenH / screenW > previewH / previewW) {
          scaleW = screenH / previewH * previewW;
          scaleH = screenH;
          var difW = (scaleW - screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          w = _w * scaleW;
          if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
          y = _y * scaleH;
          h = _h * scaleH;
        } else {
          scaleH = screenW / previewW * previewH;
          scaleW = screenW;
          var difH = (scaleH - screenH) / scaleH;
          x = _x * scaleW;
          w = _w * scaleW;
          y = (_y - difH / 2) * scaleH;
          h = _h * scaleH;
          if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
        }
        print("eeeeeeeeeeeeeeeeeeeee${re["detectedClass"]}");
        if(re["detectedClass"] == 'person') return Positioned(
          left: math.max(0, x),
          top: math.max(0, y + h * 0.15),
          width: w,
          height: h/2,
          child: Container(
            padding: EdgeInsets.only(top: 15.0,bottom: 50 ),
            child: Stack(
              children: [
                ClipRRect(
                  child: Image.asset(
                    imgLoc,
                    fit: BoxFit.contain,
                    width: w,
                    height: h - 150,
                  ),
                ),
                  Positioned(
                  top: h * 0.17,
                  right: 0,
                  left: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.network(
                      imgRem,
                      fit: BoxFit.contain,
                      width: w/4,
                      height: h/10,
                    ),
                  ),
                ),
              ],
            )
          ),
        );
        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: Container(
            padding: EdgeInsets.only(top: 5.0, left: 5.0),

          ),
        );
      }).toList();
    }

    List<Widget> _renderStrings() {
      double offset = -10;
      return results.map((re) {
        offset = offset + 14;
        return Positioned(
          left: 10,
          top: offset,
          width: screenW,
          height: screenH,
          child: Text(
            "${re["label"]} ${(re["confidence"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              color: Color.fromRGBO(37, 213, 253, 1.0),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList();
    }

    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      results.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;

          if (screenH / screenW > previewH / previewW) {
            scaleW = screenH / previewH * previewW;
            scaleH = screenH;
            var difW = (scaleW - screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = screenW / previewW * previewH;
            scaleW = screenW;
            var difH = (scaleH - screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }
          return Positioned(
            left: x - 6,
            top: y - 6,
            width: 100,
            height: 12,
            child: Container(
              child: Text(
                "● ${k["part"]}",
                style: TextStyle(
                  color: Color.fromRGBO(37, 213, 253, 1.0),
                  fontSize: 12.0,
                ),
              ),
            ),
          );
        }).toList();

        lists..addAll(list);
      });

      return lists;
    }

    return Stack(
      children: model == mobilenet
          ? _renderStrings()
          : model == posenet ? _renderKeypoints() : _renderBoxes(),
    );
  }
}
