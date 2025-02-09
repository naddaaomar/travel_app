import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/screens/home/views/widgets/location_card.dart';
import 'package:p/screens/home/views/widgets/nearby_places.dart';
import 'package:p/screens/home/views/widgets/recommended_places.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 18.w),
      child: ListView(
        shrinkWrap: true,
        physics:  BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(right: 10.w, top: 10.h),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: 94.w,
                  height: 40.h,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Spacer(),
            ],
          ),
           SizedBox(height: 20.h),
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
                onPressed: () {},
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
