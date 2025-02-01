import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';

class  ThemeApp extends StatefulWidget {
  ThemeApp({super.key});

  @override
  State<ThemeApp> createState() => _ThemeAppState();
}

class _ThemeAppState extends State<ThemeApp> {


  int? nullableValueMode;
  void didChangeDependencies() {
    super.didChangeDependencies();
    nullableValueMode =  context.read<ThemeBloc>().state == ThemeMode.dark? 1 : 0;

    setState(() {});
  }

  Widget rollingIconBuilderMode(int? valueMode, bool foreground) {
    return Icon(iconDataByValueMode(valueMode));
  }

  IconData iconDataByValueMode(int? valueMode) => switch (valueMode) {
    0 => Icons.sunny,
    1 => Icons.dark_mode,
    _ => Icons.dark_mode,
  };

  @override
  Widget build(BuildContext context) {
    Locale currentLocal =context.locale;
    return   AnimatedToggleSwitch<int?>.rolling(
        current: nullableValueMode,
        allowUnlistedValues: true,
        values: const [0, 1],
        onChanged: (i) {
          bool isDark = i == 1;
          context.read<ThemeBloc>().add(ChangeTheme(isDark));
          if (mounted) {
            setState(() {

              nullableValueMode = i;
            });
          }

        },

        iconBuilder: rollingIconBuilderMode,
        borderWidth: 4.5,
        style:  ToggleStyle(
          indicatorColor: ColorApp.secondaryColor,
          backgroundGradient: LinearGradient(colors: currentLocal==Locale("en")? [

            ColorApp.primaryColor,
            ColorApp.primaryColorDark
          ]:[ColorApp.primaryColorDark, ColorApp.primaryColor,]),
          borderColor: Colors.transparent,
        ),
        height: 55,
        spacing: 50.0);
  }
}
