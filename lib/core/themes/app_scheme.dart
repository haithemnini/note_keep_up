import 'package:flutter/material.dart';

@immutable
class AppScheme {
  const AppScheme._();
  static const ColorScheme flexSchemeLight = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff0000ba),
    onPrimary: Color(0xffffffff),
    secondary: Color(0xff018786),
    onSecondary: Color(0xffffffff),
    error: Color(0xff790000),
    onError: Color(0xffffffff),
    background: Color(0xfff8f8fd),
    onBackground: Color(0xff090909),
    surface: Color(0xfff8f8fd),
    onSurface: Color(0xff090909),
  );

  static const ColorScheme flexSchemeDark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xffefb7ff),
    onPrimary: Color(0xff141214),
    secondary: Color(0xff66fff9),
    onSecondary: Color(0xff0c1414),
    error: Color(0xff9b374d),
    onError: Color(0xff10080a),
    background: Color(0xff1c191d),
    onBackground: Color(0xffedeced),
    surface: Color(0xff1c191d),
    onSurface: Color(0xffedeced),
  );
}
