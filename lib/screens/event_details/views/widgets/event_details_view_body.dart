import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'event_on_map.dart';
import 'view_all_recommended_events.dart';

class EventDetailsViewBody extends StatefulWidget {
  const EventDetailsViewBody({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  State<EventDetailsViewBody> createState() => _TripDetailsViewBodyState();
}

class _TripDetailsViewBodyState extends State<EventDetailsViewBody> {
  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 0.3,
              width: double.maxFinite,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20.r)),
                      image: DecorationImage(
                        image: AssetImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    left: 0.w,
                    child: FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isLight
                              ? Colors.white.withOpacity(0.7)
                              : ColorApp.cardColorDark.withOpacity(.7),
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(15.r)),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              iconSize: 20.w,
                              icon: Icon(
                                Ionicons.chevron_back,
                                color: isLight ? Colors.brown : Colors.white,
                              ),
                            ),
                            IconButton(
                              iconSize: 18.w,
                              onPressed: () {},
                              icon: FavoriteButton(valueChanged:(_isFavorite) {
                                print('Is Favorite : $_isFavorite');
                              },),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 230.h),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: isLight
                      ? ColorApp.secondaryColor
                      : ColorApp.secondaryColorDark,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      topLeft: Radius.circular(20.r))),
              child: Padding(
                padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        duration: Duration(milliseconds: 1150),
                        child: Row(children: [
                          Text('Event'.tr(),
                              style: TextStyle(
                                  fontFamily: "vol",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                  color:
                                      isLight ? Colors.black : Colors.white)),
                          Spacer(),
                          Row(
                            children: const [
                              Text(
                                "Date  ",
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "7/7/2025",
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 1450),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: isLight
                                  ? ColorApp.primaryColor
                                  : ColorApp.primaryColorDark,
                              size: 10.w,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'description'.tr(),
                              style: TextStyle(
                                  fontFamily: "pop",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isLight ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 1600),
                        child: Text(
                          "egypt’s Hidden Gem ,Dahab is a dream come true for thrill-seekers and nature"
                          " enthusiasts alike. The town is world-renowned for its diving spots, "
                          "particularly the Blue Hole, a bucket-list destination for divers"
                          " drawn to its underwater caves and vibrant marine life.",
                          style: TextStyle(
                              fontFamily: "pop",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                              color: isLight ? Colors.black : Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 2050),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: isLight
                                    ? ColorApp.primaryColor
                                    : ColorApp.primaryColorDark,
                                size: 10.w,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'show on map'.tr(),
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isLight ? Colors.black : Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 2200),
                        child: EventOnMap(
                            Latitude: 28.5093,
                            Longitude: 34.5136,
                            width: double.infinity,
                            hight: 200.h),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 2800),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                HomeViewBody.currentIndex = 2;
                              });

                              Future.delayed(
                                Duration(milliseconds: 200),
                                () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewAllEvents(),
                                      ));
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shadowColor: isLight
                                  ? ColorApp.primaryColor
                                  : ColorApp.primaryColorDark,
                              backgroundColor: isLight
                                  ? ColorApp.primaryColor
                                  : ColorApp.primaryColorDark,
                            ),
                            child: Text(
                              "Interested".tr(),
                              style: TextStyle(
                                  fontFamily: "pop",
                                  color: Colors.white,
                                  fontSize: 15.sp),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 2950),
                        child: Center(
                            child: Text(
                          "what are you waiting for ?".tr(),
                          style: TextStyle(
                              fontFamily: "pop",
                              fontSize: 12,
                              color: isLight ? Colors.black : Colors.white),
                        )),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 3100),
                        child: Center(
                            child: Text(
                          "discover more.".tr(),
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "pop",
                              color: isLight ? Colors.black : Colors.white),
                        )),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
