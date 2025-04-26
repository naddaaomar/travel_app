import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/models/inclusion_model.dart';
import 'package:p/models/photo_gallery_model.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/company_profile/views/company_profile.dart';
import 'package:p/screens/trip_details/views/widgets/activities_bottom_sheet.dart';
import 'package:p/screens/trip_details/views/widgets/trip_on_map.dart';
import 'package:shimmer/shimmer.dart';

class DiscountTripDetails extends StatefulWidget {
  const DiscountTripDetails(
      {Key? key,
      required this.image,
      required this.newPrice,
      required this.oldPrice,
      required this.place,
      required this.discountAmount})
      : super(key: key);
  final String image;
  final String place;
  final double oldPrice;
  final double newPrice;
  final double discountAmount;

  @override
  State<DiscountTripDetails> createState() => _DiscountTripDetailsState();
}

class _DiscountTripDetailsState extends State<DiscountTripDetails> {
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
                              iconSize: 20.w,
                              onPressed: () {},
                              icon: Icon(
                                Ionicons.heart_outline,
                                color: isLight ? Colors.brown : Colors.white,
                              ),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.place.tr(),
                                style: TextStyle(
                                    fontFamily: "vol",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.sp,
                                    color:
                                        isLight ? Colors.black : Colors.white)),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                      decoration: 
                                      BoxDecoration(color: Color(0xff811500),
                                      borderRadius: BorderRadius.circular(5)),
                                      child: Text("-${widget.discountAmount.toStringAsFixed(0)}",
                                      style: TextStyle(color: Colors.white,
                                      fontFamily: "pop",
                                      fontSize: 10),),
                                    ),
                                    SizedBox(width: 5,),
                                    Shimmer.fromColors(
                                      baseColor: ColorApp.primaryColor,
                                      highlightColor: Colors.grey.shade300,
                                      period: Duration(milliseconds: 2100),

                                      child: Text(
                                        "EGP ${widget.newPrice.toStringAsFixed(0)}",
                                        style: TextStyle(
                                          fontFamily: "pop",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.sp,

                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Text(
                                  "EGP ${widget.oldPrice.toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontFamily: "pop",
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,

                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 1300),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "start date",
                                  style: TextStyle(
                                      fontFamily: "pop", fontSize: 11),
                                ),
                                Text(
                                  "7/7/2025",
                                  style: TextStyle(
                                      fontFamily: "pop", fontSize: 10),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("end date",
                                    style: TextStyle(
                                        fontFamily: "pop", fontSize: 11)),
                                Text("15/7/2025",
                                    style: TextStyle(
                                        fontFamily: "pop", fontSize: 10))
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 4.w),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CompanyProfile(),
                                          ));
                                    },
                                    iconSize: 20.w,
                                    icon: Icon(
                                        Ionicons.chatbubble_ellipses_outline,
                                        color: isLight
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                      border: GradientBoxBorder(
                                          gradient: LinearGradient(colors: [
                                            Color(0xffFF9884),
                                            ColorApp.thirdColor
                                          ]),
                                          width: 2)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Available",
                                        style: TextStyle(
                                          fontFamily: "pop",
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        "10",
                                        style: TextStyle(
                                            fontFamily: "pop", fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                                  fontSize: 13.sp,
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
                              color: isLight ? Colors.black : Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 1750),
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
                              'photo Gallery'.tr(),
                              style: TextStyle(
                                  fontFamily: "pop",
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isLight ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 20),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.asset(
                                photoGalleryModel[index].image,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
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
                                    fontSize: 13.sp,
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
                        child: TripOnMap(
                            Latitude: 28.5093,
                            Longitude: 34.5136,
                            width: double.infinity,
                            hight: 200.h),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 2350),
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
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => ActivitiesBottomSheet(),
                                );
                              },
                              child: Text(
                                'Activities '.tr(),
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isLight ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 2350),
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
                              'inclusion'.tr(),
                              style: TextStyle(
                                fontFamily: "pop",
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: isLight ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 2500),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 4.h),
                          child: Text(
                            "why book this trip ?".tr(),
                            style: TextStyle(
                                fontFamily: "pop",
                                fontSize: 12,
                                color: isLight ? Colors.black : Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 2650),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: isLight
                                        ? ColorApp.primaryColor
                                        : ColorApp.primaryColorDark,
                                    size: 6.w,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "${inclusionModel[index].label.tr()}",
                                    style: TextStyle(
                                        fontFamily: "pop",
                                        fontSize: 12,
                                        color: isLight
                                            ? Colors.black
                                            : Colors.white),
                                  )),
                                ],
                              ),
                            );
                          },
                          itemCount: inclusionModel.length,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
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
                                        builder: (context) => HomeViewBody(),
                                      ));
                                },
                              );
                            },
                            child: Text(
                              "book Trip".tr(),
                              style: TextStyle(
                                  fontFamily: "pop",
                                  color: Colors.white,
                                  fontSize: 15.sp),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shadowColor: isLight
                                  ? ColorApp.primaryColor
                                  : ColorApp.primaryColorDark,
                              backgroundColor: isLight
                                  ? ColorApp.primaryColor
                                  : ColorApp.primaryColorDark,
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
                              fontSize: 13,
                              color: isLight ? Colors.black : Colors.white),
                        )),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 3100),
                        child: Center(
                            child: Text(
                          "book your trip now.".tr(),
                          style: TextStyle(
                              fontFamily: "pop",
                              fontSize: 13,
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
