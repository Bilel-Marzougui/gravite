import 'dart:convert';

import 'package:graviitee/app/data/remote/Api_request.dart';



class TermService {
  static TermService _instance;

  static TermService getInstance() {
    if (_instance == null)
      _instance = TermService();
    return _instance;
  }

  Future term({Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/configuration/termofuse";
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