import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorApp.secondaryColor,
    appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorApp.primaryColor)),


  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorApp.secondaryColorDark,
    appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(

            //color: Colors.white
            )),


  );
}
