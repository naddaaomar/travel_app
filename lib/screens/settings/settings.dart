import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/screens/home/views/widgets/drawer_body.dart';
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
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;

    return SafeArea(
      child: Scaffold(
        endDrawer: DrawerBody(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          iconTheme: IconThemeData(
            color: isLight ? ColorApp.primaryColor : ColorApp.primaryColorDark,
            size: 27,
          ),
          backgroundColor: Colors.transparent,
          title: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
            width: 100,
            height: 40,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUp(
                child: Text(
                  "settings".tr(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: isLight ? Colors.black : Colors.white),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FadeInUp(
                child: Row(
                  children: [
                    Text(
                      "theme".tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: isLight ? Colors.black : Colors.white),
                    ),
                    Spacer(),
                    ThemeApp(),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              FadeInUp(
                child: Row(
                  children: [
                    Text(
                      "language".tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
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
    );
  }
}
