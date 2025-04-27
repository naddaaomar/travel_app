import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/models/recommended_places.dart';
import 'package:p/screens/event_details/views/widgets/event_details_view_body.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';

class ViewAllEventsBody extends StatelessWidget {
  const ViewAllEventsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return MaterialButton(
      onPressed: () {
      },
      child: ListView(
        children: List.generate(recommendedPlaces.length, (index) {
          return Padding(
              padding:  EdgeInsets.only(bottom:18.h),
              child: SizedBox(
                  height: 140.h,
                  width: double.maxFinite,

                  child: Card(
                    color: isLight?Colors.white:ColorApp.cardColorDark,
                    elevation: 10,

                    shadowColor: isLight?ColorApp.primaryColor:ColorApp.primaryColorDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.r),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailsViewBody(image: '',
                              ),
                            ));
                      },
                      child: Padding(
                        padding:  EdgeInsets.all(8.0.h),
                        child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.asset(
                                  recommendedPlaces[index].image,
                                  height: double.maxFinite,
                                  width: 130.w,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              SizedBox(width: 10.w),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.w,  ),
                                            child: Text(
                                              'Event'.tr(),
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
                                            Icons.date_range_rounded,
                                            color: ColorApp.primaryColor,
                                            size: 14.w,
                                          ),
                                          Text(
                                            'date'.tr(),
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
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  )));
        }),
      ),
    );
  }
}