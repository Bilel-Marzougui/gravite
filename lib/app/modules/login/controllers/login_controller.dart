import 'dart:async';
import 'package:dio/dio.dart' as a;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graviitee/app/modules/home/views/home_view.dart';
import 'package:graviitee/app/modules/login/data/login_data.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

const GITHUB_CLIENT_ID = "88c50d818f0ceeb79ae9";
const GITHUB_CLIENT_SECRET = "4222da4c99cf30702165f7c5cbb6a6b48790e1a2";

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController password = new TextEditingController();
  TextEditingController email = new TextEditingController();
  final requiredValidator = RequiredValidator(errorText: 'Ce champ est requis');
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Adresse E-mail requis'),
    EmailValidator(errorText: 'enter a valid email address')
  ]);
  RxBool loginButtonPressed = false.obs;
  final box = GetStorage();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();

  @override
  void onInit() {
    super.onInit();
    loader = false;
    initDeepLinkListener();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void googleSignInMethod() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    print(googleUser);
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
  }

  void facebookSignInMethod() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logIn(['email', 'public_profile']);
  }

  StreamSubscription _subs;
  bool loader;

  void initDeepLinkListener() async {
    print("dddddddddddddddddddd");
    _subs = getLinksStream().listen((String link) {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee$link");
      _checkDeepLink(link);
    }, cancelOnError: true);
  }

  Future loginWithTwitter() async {
    var twitterLogin = new TwitterLogin(
      consumerKey: 'Y2MyConsumerKeyYKX',
      consumerSecret: 'xYXUMyConsumerSecretKeyjFAJZMyConsumerSecretKeyS3i',
    );

    final TwitterLoginResult result = await twitterLogin.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        var session = result.session;
        print("okkkkkkkkkkkkkkkkk");
        break;
      case TwitterLoginStatus.cancelledByUser:
        debugPrint(result.status.toString());
        return null;
        break;
      case TwitterLoginStatus.error:
        debugPrint(result.errorMessage.toString());
        return null;
        break;
    }
    return null;
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      LoginService.getInstance().loginWithGitHub(code).then((firebaseUser) {
        print(firebaseUser.email);
        print(firebaseUser.photoURL);
        print("LOGGED IN AS: " + firebaseUser.displayName);
      }).catchError((e) {
        print("LOGIN ERROR: " + e.toString());
      });
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs.cancel();
      _subs = null;
    }
  }

  void onClickGitHubLoginButton() async {
    const String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" +
        GITHUB_CLIENT_ID +
        "&scope=public_repo%20read:user%20user:email";

    if (await canLaunch(url)) {
      loader = true;
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      loader = false;
      print("CANNOT LAUNCH THIS URL!");
    }
  }

  login() async {
    if (formKey.currentState.validate()) {
      SmartDialog.showLoading(backDismiss: true);
      await LoginService.getInstance()?.login(
          a.FormData.fromMap({
            "email": email.text,
            "password": password.text,
          }), onSuccess: (data) async {
        print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz$data");
        if (data == null) {
        } else {
          print("dataaaaaaaaaaaaaaaaaaaaaa${data.data['status']}");
          if (data.data['status'] == 1) {
            box.write('customer_id', data.data['customer_id']);
            box.write('email', data.data['info']['email']);
            box.write('username', data.data['info']['username']);
            //box.write('token', data.data['token']);
            print("vvvvvvvvvvvvvvvvvvvvvvvv" + box.read('customer_id'));
            print("vvvvvvvvvvvvvvvvvvvvvvvv" + box.read('email'));
            SmartDialog.dismiss();
            Get.to(() => HomeView());
            Get.snackbar("Success", "Hello ${data.data['info']['username']}",
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Color(0xff3fbbce),
                duration: Duration(seconds: 6));
          } else
            Get.snackbar("Error", "no");
        }
      }, onError: (e) {});
    }
  }
}
