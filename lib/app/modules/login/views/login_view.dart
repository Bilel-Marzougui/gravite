import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:get/get.dart';
import 'package:github_login/github_login.dart';
import 'package:graviitee/app/modules/home/views/home_view.dart';
import 'package:graviitee/app/modules/signup/bindings/signup_binding.dart';
import 'package:graviitee/app/modules/signup/views/signup_view.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    controller.initDeepLinkListener();
    return WillPopScope(
      onWillPop: (){
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white70,
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      child: Image.asset(
                        "assets/log.png",
                        height: 150,
                        width: 350,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.email,
                    validator: controller.emailValidator,
                    showCursor: true,
                    keyboardType: TextInputType.emailAddress ,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xFF666666),
                        size: 17,
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: 'Roboto-Light.ttf',
                          fontSize: 14),
                      hintText: "Username",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: controller.password,
                    obscureText: true,
                    validator: controller.requiredValidator,
                    showCursor: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Color(0xFF666666),
                        size: 17,
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: TextStyle(
                        color: Color(0xFF666666),
                        fontFamily: 'Roboto-Light.ttf',
                        fontSize: 14,
                      ),
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Obx(()=>(controller.loginButtonPressed.value == true) ?  JumpingDotsProgressIndicator(
                    fontSize: 40.0,
                  ):  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      padding: EdgeInsets.all(14.0),
                      onPressed: () =>  controller.login(),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins-Medium.ttf',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      color: Color(0xff3fbbce),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          side: BorderSide(color: Color(0xff3fbbce))),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                  ),),
                  SizedBox(height: 10,),
                  Row(children: <Widget>[
                    Expanded(
                        child: Divider(
                          indent: 10,
                          endIndent: 15,
                        )),
                    Text("OR"),
                    Expanded(
                        child: Divider(
                          indent: 15,
                          endIndent: 5,
                        )),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignInButton(
                        Buttons.Facebook,
                        mini: true,
                        onPressed: ()=> controller.facebookSignInMethod(),
                      ),
                      SignInButton(
                        Buttons.Apple,
                        mini: true,
                        onPressed: () => controller.googleSignInMethod(),
                      ),
                      SignInButton(
                        Buttons.Twitter,
                        mini: true,

                        onPressed: () => controller.loginWithTwitter(),
                      ),
                      SignInButton(
                        Buttons.LinkedIn,
                        mini: true,

                        onPressed: () {},
                      ),
                      SignInButton(
                        Buttons.GitHub,
                        mini: true,

                        onPressed: () async {
                          GithubLogin user = new GithubLogin();
                          String token = await user.getToken(context: context,
                             clientId: "88c50d818f0ceeb79ae9",
                              clientSecret: "4222da4c99cf30702165f7c5cbb6a6b48790e1a2",
                              callBackUrl:"https://graviitee-5ec20.firebaseapp.com");
                          print("TOKEN FROM PLUGIN ::: $token");
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "You do not have an account?",
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontFamily: 'Roboto-Light.ttf',
                              fontSize: 17,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                              Get.to(()=>SignupView(),binding: SignupBinding())
                          },
                          child: Container(
                            child: Text(
                              " Register",
                              style: TextStyle(
                                color: Color(0xff3fbbce),
                                fontFamily: 'Roboto-Light.ttf',
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
