import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:graviitee/app/data/local/models/githubResponse.dart';
import 'package:graviitee/app/data/remote/Api_request.dart';
import 'package:graviitee/app/modules/login/controllers/login_controller.dart';
import 'package:http/http.dart' as http;


class TryDesignService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  static TryDesignService _instance;

  static TryDesignService getInstance() {
    if (_instance == null) _instance = TryDesignService();
    return _instance;
  }

  Future addToFavorites(data, {Function onSuccess, Function onError}) async {
    try {
      String url =
          "http://graviitee.net/dev/mobileapi/mygrav/addtofavorites/";
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
  Future saveOnMyGrave(data, {Function onSuccess, Function onError}) async {
    try {
      String url =
          "http://graviitee.net/dev/mobileapi/mygrav/saveonmygrave/";
      print(url);
      var response = await ApiRequest(
        url: url,
        data: data,
      ).post();
      onSuccess(response);
    } catch (e) {
      print(e);
      onError(e);
    }
  }

}
