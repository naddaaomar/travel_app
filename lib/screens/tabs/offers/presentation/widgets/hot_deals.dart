import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';

class HotDeals extends StatelessWidget {
  final List<String> adsImages;
  final int currentIndex;
  final Timer timer;

  const HotDeals({
    super.key,
    required this.adsImages,
    required this.currentIndex,
    required this.timer,
  });

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 2000),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                fit: BoxFit.fill,
                width: 330,
                height: 200,
                adsImages[currentIndex],
                key: ValueKey<int>(currentIndex),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 210,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: adsImages.map((image) {
              int index = adsImages.indexOf(image);
              return Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex == index
                      ? isLight?ColorApp.primaryColor:ColorApp.primaryColorDark
                      : Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
