import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/event_details/views/widgets/view_all_recommended_events.dart';
import 'package:p/screens/home/views/widgets/search/location_card_new.dart';
import 'package:p/screens/home/views/widgets/nearby_places.dart';
import 'package:p/screens/home/views/widgets/recommended_places.dart';
import 'dart:ui' as ui;

import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/trip_details/views/widgets/view_all_nearby_trips.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LocationCardNew(),
              SizedBox(
                height: 20,
              ),
              // LocationCard(),
              // SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended Events'.tr(),
                    style: TextStyle(
                        fontFamily: "vol",
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp,
                        color: isLight ? Colors.black : Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAllEvents()));
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: Text(
                      'view All'.tr(),
                      style: TextStyle(
                          fontFamily: "vol",
                          fontSize: 13.sp,
                          color: isLight ? ColorApp.thirdColor : Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9.h),
              RecommendedPlaces(),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nearby'.tr(),
                    style: TextStyle(
                        fontFamily: "vol",
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                        color: isLight ? Colors.black : Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAllTrips()));
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: Text(
                      'view All'.tr(),
                      style: TextStyle(
                          fontFamily: "vol",
                          fontSize: 13.sp,
                          color: isLight ? ColorApp.thirdColor : Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.h),
              NearbyPlaces(),
            ],
          ),
        ),
      ),
    );
  }
}