import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:get/get.dart';
import 'package:graviitee/app/modules/home/controllers/home_controller.dart';
import 'package:tflite/tflite.dart';

import 'bndbox.dart';
import 'camera.dart';
import 'models.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  String imagRem;
  final String imagLoc;

  HomePage(this.cameras, this.imagRem, this.imagLoc);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  bool isDesign = true;
  String _selectedFont = "Roboto";
  TextStyle _selectedFontTextStyle;
  TextEditingController inputShort = TextEditingController();
  List<String> _myGoogleFonts = [
    "Abril Fatface",
    "Aclonica",
    "Alegreya Sans",
    "Architects Daughter",
    "Archivo",
    "Archivo Narrow",
    "Bebas Neue",
    "Bitter",
    "Bree Serif",
    "Bungee",
    "Cabin",
    "Cairo",
    "Coda",
    "Comfortaa",
    "Comic Neue",
    "Cousine",
    "Croissant One",
    "Faster One",
    "Forum",
    "Great Vibes",
    "Heebo",
    "Inconsolata",
    "Josefin Slab",
    "Lato",
    "Libre Baskerville",
    "Lobster",
    "Lora",
    "Merriweather",
    "Montserrat",
    "Mukta",
    "Nunito",
    "Offside",
    "Open Sans",
    "Oswald",
    "Overlock",
    "Pacifico",
    "Playfair Display",
    "Poppins",
    "Raleway",
    "Roboto",
    "Roboto Mono",
    "Source Sans Pro",
    "Space Mono",
    "Spicy Rice",
    "Squada One",
    "Sue Ellen Francisco",
    "Trade Winds",
    "Ubuntu",
    "Varela",
    "Vollkorn",
    "Work Sans",
    "Zilla Slab"
  ];

  @override
  void initState() {
    super.initState();
    onSelect('SSD MobileNet');
  }

  loadModel() async {
    String res;
    switch (_model) {
      case yolo:
        res = await Tflite.loadModel(
          model: "assets/yolov2_tiny.tflite",
          labels: "assets/yolov2_tiny.txt",
        );
        break;

      case mobilenet:
        res = await Tflite.loadModel(
            model: "assets/mobilenet_v1_1.0_224.tflite",
            labels: "assets/mobilenet_v1_1.0_224.txt");
        break;

      case posenet:
        res = await Tflite.loadModel(
            model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
        break;

      case ssd:
        res = await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt");
    }
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    print("dddddddddddddddddddddddddddd$_model");
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  GlobalKey globalKey = GlobalKey();

  double x1 = 100.0,
      x2 = 100.0,
      y1 = 100.0,
      y2 = 100.0,
      x1Prev = 100.0,
      x2Prev = 200.0,
      y1Prev = 100.0,
      y2Prev = 100.0;
  bool body = false;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    HomeController homeController = Get.find();

    return Scaffold(
      body: _model == ""
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: const Text(ssd),
                    onPressed: () => onSelect(ssd),
                  ),
                  RaisedButton(
                    child: const Text(yolo),
                    onPressed: () => onSelect(yolo),
                  ),
                  RaisedButton(
                    child: const Text(mobilenet),
                    onPressed: () => onSelect(mobilenet),
                  ),
                  RaisedButton(
                    child: const Text(posenet),
                    onPressed: () => onSelect(posenet),
                  ),
                ],
              ),
            )
          : RepaintBoundary(
              key: globalKey,
              child: Stack(
                children: [
                  Camera(
                    widget.cameras,
                    _model,
                    setRecognitions,
                  ),
                  isDesign
                      ? Positioned(
                          left: x2,
                          top: y2,
                          child: GestureDetector(
                            onLongPressDown: (d) {
                              x2Prev = x2;
                              y2Prev = y2;
                            },
                            onLongPressMoveUpdate: (details) {
                              setState(() {
                                x2 = x2Prev + details.localPosition.dx;
                                y2 = y2Prev + details.localPosition.dy;
                              });
                            },
                            child: Container(
                              child: Image.network(
                                widget.imagRem,
                                height: x1,
                                width: y1,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  isDesign
                      ? Positioned(
                          right: 10,
                          top: Get.height * .5,
                          child: Container(
                            child: Column(
                              children: [
                                IconButton(onPressed: (){
                                  setState(() {
                                    x1 += 1;
                                    y1 += 1;
                                  });
                                }, icon: Icon(Icons.zoom_in,size: 30,color: Colors.white,)),
                                IconButton(onPressed: (){
                                  setState(() {
                                    x1 -= 1;
                                    y1 -= 1;
                                  });
                                }, icon: Icon(Icons.zoom_out,size: 30,color: Colors.white,)),
                              ],
                            )
                          ),
                        )
                      : SizedBox(),
                  Positioned(
                      left: 10,
                      top: Get.height * 0.5,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isDesign = true;
                          });
                        },
                        child: Image.asset(
                          'assets/1_short_white_v.png',
                          color: isDesign ? Color(0xff3fbbce) : Colors.white,
                          height: 50,
                          width: 50,
                        ),
                      )),

                  Positioned(
                      left: 23,
                      top: Get.height * 0.52,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isDesign = true;
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: isDesign ? Colors.white : Colors.black,
                        ),
                      )),
                  Positioned(
                      left: 10,
                      top: Get.height * 0.6,
                      child: InkWell(
                        onTap: () {
                          print('rrrrrrrrrrrrrrrrrr');
                          setState(() {
                            isDesign = false;
                          });
                        },
                        child: Image.asset(
                          'assets/1_short_white_v.png',
                          height: 50,
                          width: 50,
                          color: !isDesign ? Color(0xff3fbbce) : Colors.white,
                        ),
                      )),
                  Positioned(
                      top: Get.height * 0.7,
                      width: Get.width,
                      child: isDesign == true
                          ? Container(
                              height: 75,
                              color: Colors.transparent,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: List.generate(
                                      homeController.listOfProd.length,
                                      (index) => Container(
                                            padding: EdgeInsets.all(7),
                                            margin: EdgeInsets.all(2),
                                            height: 75,
                                            width: 60,
                                            color: Colors.white,
                                            child: InkWell(
                                              onTap: () {
                                                // controller.prod.value = homeController.listOfProd[index];
                                                setState(() {
                                                  widget.imagRem =
                                                      homeController
                                                          .listOfProd[index]
                                                          .img;
                                                });
                                              },
                                              child: ClipRRect(
                                                child: Image.network(
                                                  homeController
                                                      .listOfProd[index].img,
                                                  fit: BoxFit.contain,
                                                  height: 75,
                                                  width: 60,
                                                ),
                                              ),
                                            ),
                                          )),
                                ),
                              ),
                            )
                          : SizedBox()),
                  !isDesign
                      ? BndBox(
                          _recognitions == null ? [] : _recognitions,
                          math.max(_imageHeight, _imageWidth),
                          math.min(_imageHeight, _imageWidth),
                          screen.height,
                          screen.width,
                          _model,
                          widget.imagRem,
                          widget.imagLoc)
                      : SizedBox(),
                ],
              ),
            ),

      /* floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            //extract bytes
            final RenderRepaintBoundary boundary =
                globalKey.currentContext.findRenderObject();
            final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
            final ByteData byteData =
                await image.toByteData(format: ui.ImageByteFormat.png);
            final Uint8List pngBytes = byteData.buffer.asUint8List();

            //create file
            final String dir = (await getApplicationDocumentsDirectory()).path;
            final String fullPath = '$dir/${DateTime.now().millisecond}.png';
            File capturedFile = File(fullPath);
            await capturedFile.writeAsBytes(pngBytes);
            print(capturedFile.path);

            await GallerySaver.saveImage(capturedFile.path).then((value) {});
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.linked_camera_sharp,color: ,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*/
    );
  }
}
