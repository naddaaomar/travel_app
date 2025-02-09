import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/screens/settings/lang_bloc/lang_bloc.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/home/home_tab.dart';

import '../../helpers/themes/colors.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  Widget rollingIconBuilderLanguage(int? valueLanguage, bool foreground) {
    return CircleAvatar(
      radius: 15,
      child: ClipOval(
        child: Image.asset(
          iconDataByValueLanguage(valueLanguage),
          fit: BoxFit.cover,
          width: 40,
          height: 40,
        ),
      ),
    );
  }

  String iconDataByValueLanguage(int? valueLanguage) {
    switch (valueLanguage) {
      case 0:
        return "assets/images/ar.png";
      case 1:
        return "assets/images/en.png";
      default:
        return "assets/images/en.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, Locale>(
      builder: (context, locale) {
        int? nullableValueLanguage = locale.languageCode == "en" ? 1 : 0;
        bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

        return AnimatedToggleSwitch<int?>.rolling(
          current: nullableValueLanguage,
          allowUnlistedValues: true,
          values: const [0, 1],
          onChanged: (i) {
            // Dispatch ChangeLocale event to the Bloc
            context.read<LocaleBloc>().add(
              ChangeLocale(i == 1 ? const Locale("en") : const Locale("ar")),
            );

            // Manually trigger locale change in EasyLocalization
            EasyLocalization.of(context)?.setLocale(
              i == 1 ? const Locale("en") : const Locale("ar"),
            );
          },
          iconBuilder: rollingIconBuilderLanguage,
          borderWidth: 4.5.w,
          style: ToggleStyle(
            indicatorColor: ColorApp.secondaryColor,
            borderColor: Colors.transparent,
            backgroundColor: isLight
                ? ColorApp.primaryColor
                : ColorApp.primaryColorDark,
          ),
          height: 55.h,
          spacing: 50.0.w,
        );
      },
    );
  }
}
