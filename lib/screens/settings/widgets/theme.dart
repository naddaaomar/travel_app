import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';

class ThemeApp extends StatefulWidget {
  const ThemeApp({super.key});

  @override
  State<ThemeApp> createState() => _ThemeAppState();
}

class _ThemeAppState extends State<ThemeApp> {
  Widget rollingIconBuilderMode(int? valueMode, bool foreground) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Icon(iconDataByValueMode(valueMode),size: 22,),
    );
  }

  IconData iconDataByValueMode(int? valueMode) => switch (valueMode) {
        0 => Icons.sunny,
        1 => Icons.dark_mode,
        _ => Icons.dark_mode,
      };

  @override
  Widget build(BuildContext context) {
    Locale currentLocal = context.locale;

    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, state) {
        int currentMode = state == ThemeMode.dark ? 1 : 0;
        return AnimatedToggleSwitch<int?>.rolling(
          current: currentMode,
          allowUnlistedValues: true,
          values: const [0, 1],
          onChanged: (i) {
            bool isDark = i == 1;
            context.read<ThemeBloc>().add(ChangeTheme(isDark));
          },
          iconBuilder: rollingIconBuilderMode,
          borderWidth: 5,
          indicatorSize: Size(30.w, 30.h),
          style: ToggleStyle(
            borderColor: Colors.transparent,
            indicatorBorderRadius: BorderRadius.circular(70),
            indicatorColor: ColorApp.secondaryColor,
            backgroundGradient: LinearGradient(
              colors: currentLocal == Locale("en")
                  ? [ColorApp.primaryColor, ColorApp.primaryColorDark]
                  : [ColorApp.primaryColorDark, ColorApp.primaryColor],
            ),
          ),
          height: 38.h,
          spacing: 20.0.w,
        );
      },
    );
  }
}
