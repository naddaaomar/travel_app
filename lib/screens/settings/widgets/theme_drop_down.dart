import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:p/screens/settings/widgets/theme.dart';

import '../bloc/theme_bloc/theme_bloc.dart';

class ThemeDropDown extends StatelessWidget {
  const ThemeDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return FadeInUp(
      duration: Duration(milliseconds: 900),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: LinearGradient(
                  colors: [Color(0xffFFB184), Color(0xff7F5E41)]),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: FadeInUp(
          duration: Duration(milliseconds: 1000),
          child: Row(
            children: [
              Text(
                isLight ? "Light" : "Dark",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17.sp,
                    color: isLight ? Colors.black : Colors.white),
              ),
              Spacer(),
              ThemeApp(),
            ],
          ),
        ),
      ),
    );
  }
}
