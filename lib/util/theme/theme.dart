import 'package:conet_app/util/theme/custom_themes/app_navbartheme.dart';
import 'package:conet_app/util/theme/custom_themes/app_texttheme.dart';
import 'package:conet_app/util/theme/custom_themes/textfirmfield_thme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // light theme

  static final ThemeData light = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    textTheme: MyApptexttheme.lightTextTheme,

    inputDecorationTheme: MyTextFormFieldTheme.light,
    bottomNavigationBarTheme: AppNavbartheme.light,
  );

  // dark theme

  static final ThemeData dark = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    textTheme: MyApptexttheme.darkTextTheme,

    inputDecorationTheme: MyTextFormFieldTheme.dark,
    bottomNavigationBarTheme: AppNavbartheme.dark,
  );
}
