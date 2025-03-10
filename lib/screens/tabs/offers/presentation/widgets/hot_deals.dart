import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';

class HotDeals extends StatefulWidget {
  HotDeals({
    super.key,
  });

  @override
  State<HotDeals> createState() => _HotDealsState();
}

class _HotDealsState extends State<HotDeals> {
  final List<String> adsImages = [
    "assets/images/dahab1.jpg",
    "assets/images/dahab2.jpg",
    "assets/images/dahab3.jpg",
    "assets/images/dahab4.jpg",
    "assets/images/dahab5.jpg",
    "assets/images/dahab6.jpg",
  ];
  int _current = 0;

  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return Column(children: [
      SizedBox(
        height: 230.h,
        child: CarouselSlider(
          items: adsImages
              .map(
                (item) => Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                    child: Image.asset(item,
                        fit: BoxFit.fill, width: double.infinity),
                  ),
                ),
              )
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              viewportFraction: .9,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              scrollDirection: Axis.vertical,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: adsImages.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 8.w,
              height: 8.h,
              margin: EdgeInsets.symmetric(horizontal: 4.0.w),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key
                      ? isLight
                          ? ColorApp.primaryColor
                          : ColorApp.primaryColorDark
                      : isLight
                          ? Colors.grey
                          : Colors.white),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
