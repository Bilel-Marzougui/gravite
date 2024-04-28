import 'dart:convert';

import 'package:graviitee/app/data/remote/Api_request.dart';



class SearchService {
  static SearchService _instance;

  static SearchService getInstance() {
    if (_instance == null)
      _instance = SearchService();
    return _instance;
  }

  Future getAllTheme({Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/search/alltheme/";
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
  Future getTheme(data,{Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/search/theme/?term=${data}&p=1";
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