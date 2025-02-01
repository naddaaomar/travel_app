import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';

import '../../helpers/themes/colors.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  int? nullableValueLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    nullableValueLanguage = context.locale.languageCode == "en" ? 1 : 0;
    setState(() {});
  }

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
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;

    return AnimatedToggleSwitch<int?>.rolling(
      current: nullableValueLanguage,
      allowUnlistedValues: true,
      values: const [0, 1],
      onChanged: (i) {
        if (mounted) {
          setState(() {
            nullableValueLanguage = i;
            context.setLocale(i == 1 ? Locale("en") : Locale("ar"));
          });
        }

      },
      iconBuilder: rollingIconBuilderLanguage,
      borderWidth: 4.5,
      style: ToggleStyle(
          indicatorColor: ColorApp.secondaryColor,
          borderColor: Colors.transparent,
          backgroundColor:
              isLight ? ColorApp.primaryColor : ColorApp.primaryColorDark),
      height: 55,
      spacing: 50.0,
    );
  }
}
