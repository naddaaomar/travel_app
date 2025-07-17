import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:p/helpers/app_bar/app_bar_widget.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/settings/widgets/help_support.dart';
import 'package:p/screens/settings/widgets/language_drop_down.dart';
import 'package:p/screens/settings/widgets/notification.dart';
import 'package:p/screens/settings/widgets/permission.dart';
import 'package:p/screens/settings/widgets/privacy_security.dart';
import 'package:p/screens/settings/widgets/settings_widget.dart';
import 'package:p/screens/settings/widgets/theme_drop_down.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _advancedDrawerController = AdvancedDrawerController();
  bool isThemeDown = false;
  bool isLangDown = false;
  bool isNotifDown = false;
  bool isPermDown = false;
  bool isPrivacyDown = false;
  bool isHelpDown = false;

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
                colors:ColorApp.drawerColors,
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
              height: 75.h,
              color: isLight
                  ? ColorApp.primaryColor
                  : ColorApp.primaryColorDark,
              lable: "Settings",
              onPressed: () {
                Navigator.pop(context);
              },
              controller: _advancedDrawerController,
              menuOnPressed: () {
                _advancedDrawerController.showDrawer();
              },
            ),
            backgroundColor: isLight
                ? ColorApp.primaryColor
                : ColorApp.primaryColorDark,
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: isLight
                            ? ColorApp.secondaryColor
                            : ColorApp.secondaryColorDark,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 30.w),
                      child: Align(
                        child: Container(
                          alignment: Alignment.center,
                          height: 500,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.4), // Shadow color
                                  spreadRadius: 0,
                                  blurStyle: BlurStyle
                                      .outer, // Spread the shadow outward
                                  blurRadius: 10, // Smooth blur effect
                                  offset: Offset(0, 0), // Moves shadow downward
                                ),
                              ],
                              border: GradientBoxBorder(
                                gradient: LinearGradient(colors: [
                                  Color(0xffFFB184),
                                  Color(0xff7F5E41)
                                ]),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SettingsWidget(
                                    duration: 1100,
                                    title: "Theme",
                                    onPressed: () {
                                      setState(() {
                                        isThemeDown = !isThemeDown;
                                      });
                                    },
                                    isDown: isThemeDown),
                                isThemeDown ? ThemeDropDown() : SizedBox(),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                // SettingsWidget(
                                //     duration: 1200,
                                //     title: "Language",
                                //     onPressed: () {
                                //       setState(() {
                                //         isLangDown = !isLangDown;
                                //       });
                                //     },
                                //     isDown: isLangDown),
                                isLangDown ? LanguageDropDown() : SizedBox(),
                                SizedBox(
                                  height: 20,
                                ),
                                SettingsWidget(
                                    duration: 1300,
                                    title: "Notifications",
                                    onPressed: () {
                                      setState(() {
                                        isNotifDown = !isNotifDown;
                                      });
                                    },
                                    isDown: isNotifDown),
                                isNotifDown ? NotificationToggle() : SizedBox(),
                                SizedBox(
                                  height: 20,
                                ),
                                SettingsWidget(
                                    duration: 1400,
                                    title: "Permissions",
                                    onPressed: () {
                                      setState(() {
                                        isPermDown = !isPermDown;
                                      });
                                    },
                                    isDown: isPermDown),
                                if (isPermDown) PermissionsContainer(),
                                SizedBox(
                                  height: 20,
                                ),
                                SettingsWidget(
                                    duration: 1500,
                                    title: "Privacy & Security",
                                    onPressed: () {
                                      setState(() {
                                        isPrivacyDown = !isPrivacyDown;
                                      });
                                    },
                                    isDown: isPrivacyDown),
                                if (isPrivacyDown)
                                  FadeInUp(
                                    duration: Duration(milliseconds: 900),
                                    child: PrivacySecurityWidget(),
                                  ),
                                SizedBox(
                                  height: 20,
                                ),
                                SettingsWidget(
                                    duration: 1600,
                                    title: "Help & Support",
                                    onPressed: () {
                                      setState(() {
                                        isHelpDown = !isHelpDown;
                                      });
                                    },
                                    isDown: isHelpDown),
                                if (isHelpDown)
                                  FadeInUp(
                                    duration: Duration(milliseconds: 900),
                                    child: HelpSupportWidget(),
                                  ),
                                SizedBox(
                                  height: 20,
                                ),
                                SettingsWidget(
                                    duration: 1800,
                                    title: "App Version",
                                    onPressed: () {},
                                    isDown: false),
                              ],
                            ),
                          ),
                        ),
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