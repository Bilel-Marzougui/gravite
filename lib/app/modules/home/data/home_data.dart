import 'dart:convert';

import 'package:graviitee/app/data/remote/Api_request.dart';



class HomeService {
  static HomeService _instance;

  static HomeService getInstance() {
    if (_instance == null)
      _instance = HomeService();
    return _instance;
  }

  Future getTopDesign({Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/home/blockitems/name/top-design/";
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
  Future getDesigner({Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/home/blockitems/name/top-designer/";
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
  Future getLastDesign({Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/home/blockitems/name/last-design/";
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
  Future getNews({Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/home/blockitems/name/news/";
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