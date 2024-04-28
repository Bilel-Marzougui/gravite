
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graviitee/app/modules/map_detail/data/map_data.dart';
import 'package:graviitee/app/modules/try_design/bindings/try_design_binding.dart';
import 'package:graviitee/app/modules/try_design/views/try_design_view.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/local/models/map.dart';

class MapDetailController extends GetxController {
  var isDesigner = true.obs;
  var isDesign = false.obs;
  var designerClick = true.obs;
  var designsState = 0.obs;
  final box = GetStorage();

  var listOfDesigns = <Maps>[].obs;

  var markersDesigner = <Marker>[].obs;

  var markersDesign = <Marker>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDesignes();
    getDesigners();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getDesignes() async {
    listOfDesigns.clear();
    await MapService.getInstance()?.getDesignCor('designs/',
        onSuccess: (data) async {
      if (data == null) {
        designsState.value = 1;
      } else {
        print(data.data);
        if (data.data.length == 0)
          designsState.value = 1;
        else {
          print("vvvvvvvvv**** ${data.data.length}");
          print("vvvvvvvv**** ${data.data}");
          for (int i = 0; i < data.data.length; i++) {
            listOfDesigns.add(Maps.fromJson(data.data[i]));
            markersDesign.add(Marker(
              width: 50.0,
              height: 50.0,
              point: LatLng(double.parse(data.data[i]['lat']),
                  double.parse(data.data[i]['lng'])),
              builder: (ctx) => InkWell(
                  onTap: () {
                    print("eeeeee****${box.read('customer_id')}");
                    goTo(box.read('customer_id'), data.data[i]['id']);
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 7,
                          color: Color(0xff3fbbce),
                        ),
                      ),
                      child: ClipRRect(
                        child: Image.network(
                          data.data[i]['img'],
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ))),
            ));
          }
          designsState.value = 2;
        }

        // change(listOfDesigner, status: RxStatus.success());
      }
    }, onError: (e) {});
  }

  getDesigners() async {
    listOfDesigns.clear();
    await MapService.getInstance()?.getDesignCor('designers/',
        onSuccess: (data) async {
      if (data == null) {
        designsState.value = 1;
      } else {
        print(data.data);
        if (data.data.length == 0)
          designsState.value = 1;
        else {
          print("vvvvvvvvv********************** ${data.data.length}");
          print("vvvvvvvv************************* ${data.data}");
          for (int i = 0; i < data.data.length; i++) {
            listOfDesigns.add(Maps.fromJson(data.data[i]));
            markersDesigner.add(Marker(
              width: 50.0,
              height: 50.0,
              point: LatLng(double.parse(data.data[i]['lat']),
                  double.parse(data.data[i]['lng'])),
              builder: (ctx) => InkWell(
                onTap: ()=> goToDesign(box.read('customer_id'), data.data[i]['id']),
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 7,
                          color: Color(0xff3fbbce),
                        ),
                      ),
                      child: ClipRRect(
                        child: Image.network(
                          data.data[i]['profile_picture'],
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ))),
            ));
            isDesigner.value = true;
          }
          designsState.value = 2;
        }

        // change(listOfDesigner, status: RxStatus.success());
      }
    }, onError: (e) {});
  }

  goTo(cos, des) async {
    SmartDialog.showLoading(backDismiss: true);
    await MapService.getInstance()?.getDetailDesign(cos, des,
        onSuccess: (data) async {
      print("zzzzzzzzzzzzzzzzzzzzzzzkkkkkkkk${data.data['design']['designer']['id']}");
      goToDesign(cos, data.data['design']['designer']['id']);

    });
  }
  goToDesign(cos, des) async {
    SmartDialog.showLoading(backDismiss: true);
    await MapService.getInstance()?.getDetailDesigner(cos, des,
        onSuccess: (data) async {
      print("zzzzzzzzzzzzzzzzzzzzzzz${data.data}");
      SmartDialog.dismiss();
      showModalBottomSheet(
        context: Get.context ,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.2,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    height: Get.height * 0.55,
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Positioned(
                          top: Get.height * 0.13,
                          child: InkWell(
                            onTap: () => Get.to(() => TryDesignView(), binding: TryDesignBinding()),
                            child: ClipRRect(
                              child: Image.network(
                                data.data['banner_pic'],
                                loadingBuilder: (BuildContext context, Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Container(
                                    height: Get.height * 0.326,
                                    width: Get.width,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (BuildContext context, Object exception,
                                    StackTrace stackTrace) {
                                  return Container(
                                      height: 90,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                            color: Color(0xff3fbbce),
                                          )));
                                },
                                fit: BoxFit.cover,
                                height: Get.height * 0.35,
                                width: Get.width,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: Get.height * 0.41,
                          left: 40,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    data.data['profile_pic']),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: Get.width,
                              color: Colors.grey[200],
                              child: Center(
                                child: Text(
                                  data.data['designer'],
                                  style: TextStyle(fontSize: 21, color: Colors.grey),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.design_services,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(data.data['designs'].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 17,
                                      )),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  Icon(Icons.unfold_less_outlined, color: Colors.black, size: 30),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(data.data['followers'].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14,
                                      )),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: Get.height * .3,
                    child:  GridView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return new GridTile(
                            child: new Card(
                                elevation: 3,
                                color: Colors.white,
                                child: new Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Image.network(
                                          data.data['items'][index]['img'],
                                          width: Get.width * 0.33,
                                          height: Get.height * 0.23,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            children: [
                                              Text(data.data['items'][index]['name'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffee413f),
                                                    fontSize: 14,
                                                  )),
                                              Spacer(),
                                              Text(
                                                  "${data.data['items'][index]['price']}\$",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffee413f),
                                                    fontSize: 14,
                                                  )),
                                              SizedBox(
                                                width: 3,
                                              )
                                            ],
                                          ),
                                        )),
                                    Positioned(
                                        top: Get.height * 0.18,
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.favorite,
                                                color: Color(0xffee413f),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                  data.data['items'][index]['likes']
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffee413f),
                                                    fontSize: 14,
                                                  )),
                                            ],
                                          ),
                                        )),
                                    Positioned(
                                        top: Get.height * 0.21,
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.comment,
                                                color: Color(0xffee413f),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                  data.data['items'][index]['comments']
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffee413f),
                                                    fontSize: 14,
                                                  )),
                                            ],
                                          ),
                                        )),
                                    Positioned(
                                        left: Get.width * 0.31,
                                        top: Get.height * 0.205,
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  for (int i = 0;
                                                  i <
                                                      data.data['items'][index]
                                                      ["stock"]
                                                          .toString()
                                                          .length;
                                                  i++)
                                                    Container(
                                                      height: 20,
                                                      //padding: EdgeInsets.all(2),
                                                      margin: EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                            color: Colors.black,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                      child: Center(
                                                          child: Text(
                                                            data.data['items'][index]
                                                            ["stock"]
                                                                .toString()[i],
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                color: Colors.black),
                                                          )),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                )),
                          );
                        },
                        itemCount: data.data['items'].length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                      ),

                  )


                ],
              ),
            );
          },
        ),
      );

    });
  }
}
