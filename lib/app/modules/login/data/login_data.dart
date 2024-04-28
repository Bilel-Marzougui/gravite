import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:graviitee/app/data/local/models/githubResponse.dart';
import 'package:graviitee/app/data/remote/Api_request.dart';
import 'package:graviitee/app/modules/login/controllers/login_controller.dart';
import 'package:http/http.dart' as http;


class LoginService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  static LoginService _instance;

  static LoginService getInstance() {
    if (_instance == null) _instance = LoginService();
    return _instance;
  }

  Future login(data, {Function onSuccess, Function onError}) async {
    try {
      String url =
          "http://graviitee.net/dev/mobileapi/customer/authentificate/";
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

  Future<auth.User> loginWithGitHub(String code) async {
    //ACCESS TOKEN REQUEST
    final response = await http.post(
      Uri(path: "https://github.com/login/oauth/access_token"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(GitHubLoginRequest(
        clientId: GITHUB_CLIENT_ID,
        clientSecret: GITHUB_CLIENT_SECRET,
        code: code,
      )),
    );

    print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz$response");

    GitHubLoginResponse loginResponse =
        GitHubLoginResponse.fromJson(json.decode(response.body));

    //FIREBASE SIGNIN
    final auth.AuthCredential credential =
        auth.GithubAuthProvider.credential(loginResponse.accessToken);

    final auth.User user =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    return user;
  }

  void signOutWithGitHub() async {
    _firebaseAuth.signOut();
  }
}
