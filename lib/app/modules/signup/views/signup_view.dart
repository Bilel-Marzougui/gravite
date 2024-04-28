import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Image.asset(
                "assets/log.png",
                height: 150,
                width: 350,
              )),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
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
                          Icons.golf_course,
                          color: Color(0xFF666666),
                          size: 17,
                        ),
                        fillColor: Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: 'Roboto-Light.ttf',
                          fontSize: 14,
                        ),
                      ),
                      isEmpty: controller.currentSelectedValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.currentSelectedValue.value,
                          isDense: true,
                          onChanged: (String newValue) {
                            controller.currentSelectedValue.value = newValue;
                            state.didChange(newValue);
                            print("gggggggggggggggg$newValue");
                            switch (newValue) {
                              case 'personality':
                                controller.isPersonality.value = 1;
                                controller.isDesigner.value = 0;
                                controller.isBrand.value = 0;
                                controller.isOng.value = 0;
                                controller.isSportClub.value = 0;
                                break;
                              case 'designer':
                                controller.isPersonality.value = 0;
                                controller.isDesigner.value = 1;
                                controller.isBrand.value = 0;
                                controller.isOng.value = 0;
                                controller.isSportClub.value = 0;
                                break;
                              case 'brand':
                                controller.isPersonality.value = 0;
                                controller.isDesigner.value = 0;
                                controller.isBrand.value = 1;
                                controller.isOng.value = 0;
                                controller.isSportClub.value = 0;
                                break;
                              case 'ong':
                                controller.isPersonality.value = 0;
                                controller.isDesigner.value = 0;
                                controller.isBrand.value = 0;
                                controller.isOng.value = 1;
                                controller.isSportClub.value = 0;
                                break;
                              case 'sport club':
                                controller.isPersonality.value = 0;
                                controller.isDesigner.value = 0;
                                controller.isBrand.value = 0;
                                controller.isOng.value = 0;
                                controller.isSportClub.value = 1;
                                break;
                            }
                          },
                          items: controller.currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: controller.name,
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
                    Icons.person,
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
                controller: controller.email,
                validator: controller.emailValidator,
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
                    Icons.email,
                    color: Color(0xFF666666),
                    size: 17,
                  ),
                  /* suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye,
                        color: Color(0xFF666666),
                        size: defaultIconSize),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    ),*/
                  fillColor: Color(0xFFF2F3F5),
                  hintStyle: TextStyle(
                    color: Color(0xFF666666),
                    fontFamily: 'Roboto-Light.ttf',
                    fontSize: 14,
                  ),
                  hintText: "Email",
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
                    Icons.lock,
                    color: Color(0xFF666666),
                    size: 17,
                  ),
                  /* suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye,
                        color: Color(0xFF666666),
                        size: defaultIconSize),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    ),*/
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
              SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.all(14.0),
                  onPressed: () => controller.signup(context),
                  child: Text(
                    "Register",
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
              ),
              SizedBox(
                height: 20,
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
                        "Do you have an account?",
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: 'Roboto-Light.ttf',
                          fontSize: 17,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        child: Text(
                          " Login",
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
    );
  }
}
