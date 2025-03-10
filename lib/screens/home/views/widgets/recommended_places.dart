import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import '../../../../models/recommended_places.dart';
import '../../../trip_details/views/widgets/trip_details_view_body.dart';
import 'dart:ui' as ui;
//bool isDarkTest = true;

class RecommendedPlaces extends StatelessWidget {
  RecommendedPlaces({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return BlocConsumer<ThemeBloc, ThemeMode>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SizedBox(
          height: 261.h,
          child: Directionality(
            textDirection: ui.TextDirection.ltr,
            child: CarouselSlider(
                items: recommendedPlaces.map((index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    width: 220.w,
                    child: Card(
                      color: isLight ? Colors.white : Color(0xFF614848),
                      elevation: 10,
                      shadowColor: isLight
                          ? ColorApp.primaryColor
                          : ColorApp.primaryColorDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.r),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TripDetailsViewBody(
                                  image: index.image,
                                ),
                              ));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(7.w),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.asset(
                                    index.image,
                                    width: double.maxFinite,
                                    fit: BoxFit.cover,
                                    height: 150.h,
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: Text(
                                        'place'.tr(),
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: isLight
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade700,
                                      size: 14.w,
                                    ),
                                    Text(
                                      'rate'.tr(),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: isLight
                                              ? Colors.black
                                              : Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(2.w),
                                      child: Icon(
                                        Ionicons.location,
                                        color: ColorApp.primaryColor,
                                        size: 16.sp,
                                      ),
                                    ),
                                    Text(
                                      'location'.tr(),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: isLight
                                              ? Colors.black
                                              : Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: .6,
                  enlargeFactor: .5,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  autoPlayAnimationDuration: Duration(milliseconds: 700),
                  autoPlayCurve: Curves.easeInOutCubic,
                )),
          ),
        );
      },
    );
  }
}
