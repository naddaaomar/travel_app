import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    cardColor: Colors.white,
   // cardTheme: CardTheme(color: Colors.white),
    buttonTheme: ButtonThemeData(buttonColor: Colors.redAccent),
    scaffoldBackgroundColor: ColorApp.secondaryColor,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    cardColor: ColorApp.secondaryColorDark,
    // cardTheme: CardTheme(color: ColorApp.cardColorDark),
    scaffoldBackgroundColor: ColorApp.secondaryColorDark,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
  );
}
