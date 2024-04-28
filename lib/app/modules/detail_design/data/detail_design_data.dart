import 'dart:convert';

import 'package:graviitee/app/data/remote/Api_request.dart';



class DetailDesignService {
  static DetailDesignService _instance;

  static DetailDesignService getInstance() {
    if (_instance == null)
      _instance = DetailDesignService();
    return _instance;
  }

  Future follow(data,{Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/designer/follow/?___store=fr";
      print(url);
      var response = await ApiRequest(
        url: url,
        data: data,
      ).post();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
  }
  Future unfollow(data,{Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/designer/unfollow/?___store=fr";
      print(url);
      var response = await ApiRequest(
        url: url,
        data: data,
      ).post();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
  }
  Future comment(data,{Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/design/comment/";
      print(url);
      var response = await ApiRequest(
        url: url,
        data: data,
      ).post();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
  }
  Future like(data,{Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/design/like/";
      print(url);
      var response = await ApiRequest(
        url: url,
        data: data,
      ).post();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
  }
  Future unlike(data,{Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/design/unlike/";
      print(url);
      var response = await ApiRequest(
        url: url,
        data: data,
      ).post();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
  }
  Future getDesignDetail(data,{Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapi/design/?customer_id=${data['customer_id']}&design_id=${data['design_id']}";
      print(url);
      var response = await ApiRequest(
        url: url,
      ).get();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
  }




}