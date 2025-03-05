import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/app_bar/app_bar_widget.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';
import 'package:p/screens/settings/language.dart';
import 'package:p/screens/settings/theme.dart';

import 'theme_bloc/theme_bloc.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    Locale currentLocal = context.locale;
    return WillPopScope(
      onWillPop: () async {
        if (_advancedDrawerController.value.visible) {
          _advancedDrawerController.hideDrawer();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: AdvancedDrawer(
          backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                tileMode: TileMode.repeated,
                colors: [
                  Color(0xffC59D90),
                  Color(0xffDDBBB0),
                ],
              ),
            ),
          ),
          openScale: .9,
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: true,
          openRatio: .5,
          // openScale: 1.0,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),

          drawer: NewDrawer(
            controller: _advancedDrawerController,
          ),
          child: Scaffold(
            appBar: appBar(
              lable: "Settings",
              onPressed: () {
                Navigator.pop(context);
              },
              controller: _advancedDrawerController,
              menuOnPressed: () {
                _advancedDrawerController.showDrawer();
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
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 30.w),
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
                                      color: isLight
                                          ? Colors.black
                                          : Colors.white),
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
                                      color: isLight
                                          ? Colors.black
                                          : Colors.white),
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
        ),
      ),
    );
  }
}
