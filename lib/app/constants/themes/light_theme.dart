import 'package:flutter/material.dart';


ThemeData lightThemes() {
  ThemeData light;
  return   light = ThemeData.light().copyWith(
    backgroundColor: Color.fromRGBO(49,30,98,1),
    appBarTheme: AppBarTheme(color: Color(0xff3fbbce)),
    buttonColor: Colors.red,
  );
}