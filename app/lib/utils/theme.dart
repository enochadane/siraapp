import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
 
class AppTheme {
  //
  AppTheme._();
 
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryVariant: Colors.white38,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.black54,
    ),
    textTheme: TextTheme(
      headline1:TextStyle(
        color: Colors.black,
        fontSize: 20.0,
      ),
      headline2: TextStyle(
        color: Colors.black87,
        fontSize: 18.0,

      ),
      subtitle1: TextStyle(
        color: Colors.black87,
        fontSize: 18.0,
      ),
      subtitle2: TextStyle(
        color: Colors.black87,
        fontSize: 16.0,
      ),
      bodyText1: TextStyle(
        color: Colors.black87,
        fontSize: 18.0,
      ),
      bodyText2: TextStyle(
        color: Colors.black87,
        fontSize: 14.0,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF26242F),
    appBarTheme: AppBarTheme(
      color: Color(0xFF26242F),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF26242F),
      onPrimary: Color(0xFF26242F),
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black38,
    ),
    iconTheme: IconThemeData(
      color: Colors.white70,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold
      ),
      headline2: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,

      ),
      subtitle1: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      subtitle2: TextStyle(
        color: Colors.white70,
        fontSize: 16.0,
      ),
      bodyText1: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
      bodyText2: TextStyle(
        color: Colors.white70,
        fontSize: 14.0,
      ),
    ),
  );
}