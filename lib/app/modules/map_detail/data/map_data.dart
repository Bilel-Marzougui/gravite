import 'dart:convert';

import 'package:graviitee/app/data/remote/Api_request.dart';



class MapService {
  static MapService _instance;

  static MapService getInstance() {
    if (_instance == null)
      _instance = MapService();
    return _instance;
  }

  Future getDesignCor(s,{Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/map/$s";
      print(url);
      var response = await ApiRequest(
        url: url,
        queryParameters: null,
      ).get();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
  }
  Future getDetailDesign(custom,design,{Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/design/?customer_id=$custom&design_id=$design";
      print(url);
      var response = await ApiRequest(
        url: url,
        queryParameters: null,
      ).get();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
  }
  Future getDetailDesigner(custom,design,{Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/map/designer/?customer_id=$custom&designer_id=$design";
      print(url);
      var response = await ApiRequest(
        url: url,
        queryParameters: null,
      ).get();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
  }



}