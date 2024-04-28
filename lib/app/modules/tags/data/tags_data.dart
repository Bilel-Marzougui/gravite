import 'dart:convert';

import 'package:graviitee/app/data/remote/Api_request.dart';



class TagsService {
  static TagsService _instance;

  static TagsService getInstance() {
    if (_instance == null)
      _instance = TagsService();
    return _instance;
  }

  Future tags({Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/search/alltags/";
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