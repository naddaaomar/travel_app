import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        color: isLight
            ? ColorApp.primaryColor
            : ColorApp.primaryColorDark,
      ),
    );
  }
}
