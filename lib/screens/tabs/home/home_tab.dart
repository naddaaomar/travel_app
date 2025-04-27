import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/screens/home/views/widgets/location_card.dart';
import 'package:p/screens/home/views/widgets/main_row.dart';
import 'package:p/screens/home/views/widgets/nearby_places.dart';
import 'package:p/screens/home/views/widgets/recommended_places.dart';
import 'dart:ui' as ui;

import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/trip_details/views/widgets/view_all_nearby_trips.dart';

import '../../event_details/views/widgets/view_all_recommended_events.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          LocationCard(),
          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'recommendation'.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                    color: isLight ? Colors.black : Colors.white),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ViewAllEvents()));
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: Text(
                  'view All'.tr(),
                  style:
                      TextStyle(color: isLight ? Colors.black : Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 7.h),
          RecommendedPlaces(),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'nearby'.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                    color: isLight ? Colors.black : Colors.white),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ViewAllTrips()));
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: Text(
                  'view All'.tr(),
                  style:
                      TextStyle(color: isLight ? Colors.black : Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 7.h),
          NearbyPlaces(),
        ],
      ),
    );
  }
}
