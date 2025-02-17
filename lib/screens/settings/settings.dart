import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/app_bar/app_bar_widget.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/settings/lang_bloc/lang_bloc.dart';
import 'package:p/screens/settings/language.dart';
import 'package:p/screens/settings/theme.dart';

import 'theme_bloc/theme_bloc.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    Locale currentLocal = context.locale;
    return SafeArea(
      child: Scaffold(
        appBar: appBar(
          lable: "Settings",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorApp.primaryColor,
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: ColorApp.secondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    )),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      FadeInUp(
                        child: Row(
                          children: [
                            Text(
                              "theme".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.sp,
                                  color: isLight ? Colors.black : Colors.white),
                            ),
                            Spacer(),
                            ThemeApp(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      FadeInUp(
                        child: Row(
                          children: [
                            Text(
                              "language".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.sp,
                                  color: isLight ? Colors.black : Colors.white),
                            ),
                            Spacer(),
                            Language()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
