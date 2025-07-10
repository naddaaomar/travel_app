import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/screens/settings/bloc/lang_bloc/lang_bloc.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import '../../../helpers/themes/colors.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  Widget rollingIconBuilderLanguage(int? valueLanguage, bool foreground) {
    return CircleAvatar(

      backgroundImage: AssetImage( iconDataByValueLanguage(valueLanguage),),
      radius: 11,

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
    Locale currentLocal =context.locale;

    return BlocBuilder<LocaleBloc, Locale>(
      builder: (context, locale) {
        int? nullableValueLanguage = currentLocal == Locale("en") ? 1 : 0;
        bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

        return AnimatedToggleSwitch<int?>.rolling(
          current: nullableValueLanguage,
          allowUnlistedValues: true,
          values: const [0, 1],
          onChanged: (i) async {
            // Dispatch ChangeLocale event to the Bloc
            context.read<LocaleBloc>().add(
              ChangeLocale(
                  i == 1 ? const Locale("en") : const Locale("ar")),
            );

            // Manually trigger locale change in EasyLocalization
            await EasyLocalization.of(context)?.setLocale(
              i == 1 ? const Locale("en") : const Locale("ar"),
            );
          },
          iconBuilder: rollingIconBuilderLanguage,
          borderWidth: 5,
          indicatorSize: Size(30.w, 30.h),
          style: ToggleStyle(
            indicatorColor: ColorApp.secondaryColor,
            borderColor: Colors.transparent,
            backgroundColor:
            isLight ? ColorApp.primaryColor : ColorApp.primaryColorDark,
          ),
          height: 40.h,
          spacing: 20.0.w,
        );
      },
    );
  }
}