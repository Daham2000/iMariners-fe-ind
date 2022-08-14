import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class PrimaryTheme {
  PrimaryTheme._();

  static ThemeData generateTheme(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(4, 131, 184, .1),
      100: Color.fromRGBO(4, 131, 184, .2),
      200: Color.fromRGBO(4, 131, 184, .3),
      300: Color.fromRGBO(4, 131, 184, .4),
      400: Color.fromRGBO(4, 131, 184, .5),
      500: Color.fromRGBO(4, 131, 184, .6),
      600: Color.fromRGBO(4, 131, 184, .7),
      700: Color.fromRGBO(4, 131, 184, .8),
      800: Color.fromRGBO(4, 131, 184, .9),
      900: Color.fromRGBO(4, 131, 184, 1),
    };
    return ThemeData(
      primarySwatch: MaterialColor(0xFF1287B9, color),
      brightness: Brightness.light,
      textTheme: const TextTheme(
          headline6: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: "Avenir",
        fontSize: 18.0,
      )),
      backgroundColor: Colors.white,
    );
  }
}
