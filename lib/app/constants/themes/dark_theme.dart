import 'package:flutter/material.dart';

ThemeData darkThemes() {
  ThemeData dark;
  return dark = ThemeData.dark().copyWith(
    backgroundColor: Color.fromRGBO(49, 30, 98, 1),
    appBarTheme: AppBarTheme(

    ),

    buttonColor: Colors.red,
    primaryColor: Color.fromRGBO(49, 30, 98, 1),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      button: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      subtitle1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      caption: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
      overline: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
    ),
  );
}
