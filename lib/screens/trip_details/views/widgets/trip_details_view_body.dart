import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/models/inclusion_model.dart';
import 'package:p/models/photo_gallery_model.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/payment/presentation/pages/test_form.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/offers/presentation/pages/company_profile.dart';
import 'trip_on_map.dart';

class TripDetailsViewBody extends StatefulWidget {
  const TripDetailsViewBody({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  State<TripDetailsViewBody> createState() => _TripDetailsViewBodyState();
}

class _TripDetailsViewBodyState extends State<TripDetailsViewBody> {
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
                  child: FadeInUp(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('dahab'.tr(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                    color:
                                        isLight ? Colors.black : Colors.white)),
                            Spacer(),
                            Text(
                              "\$200",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.sp,
                                  color: isLight ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 4.w),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CompanyProfile(),
                                      ));
                                },
                                iconSize: 20.w,
                                icon: Icon(Ionicons.chatbubble_ellipses_outline,
                                    color:
                                        isLight ? Colors.black : Colors.white),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'rate'.tr(),
                                  style: TextStyle(
                                      color:
                                          isLight ? Colors.black : Colors.white,
                                      fontSize: 12.sp),
                                ),
                                Icon(
                                  Ionicons.star,
                                  color: Colors.yellow[800],
                                  size: 15.w,
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
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
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isLight ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Text(
                          "egypt’s Hidden Gem ,Dahab is a dream come true for thrill-seekers and nature"
                          " enthusiasts alike. The town is world-renowned for its diving spots, "
                          "particularly the Blue Hole, a bucket-list destination for divers"
                          " drawn to its underwater caves and vibrant marine life.",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: isLight ? Colors.black : Colors.white),
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        Row(
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
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isLight ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        GridView.builder(
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
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
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
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isLight ? Colors.black : Colors.white),
                              ),
                            ],
                          ),
                        ),
                        TripOnMap(
                            Latitude: 28.5093,
                            Longitude: 34.5136,
                            width: double.infinity,
                            hight: 200.h),
                        Row(
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
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: isLight ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 4.h),
                          child: Text(
                            "why book this trip ?".tr(),
                            style: TextStyle(
                                color: isLight ? Colors.black : Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        ListView.builder(
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
                        SizedBox(
                          height: 30.h,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                HomeViewBody.currentIndex = 2;
                              });

                              Future.delayed(Duration(milliseconds: 200),
                              () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeViewBody(),
                                    ));
                              },);
                            },
                            child: Text(
                              "book Trip".tr(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.sp),
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
                        SizedBox(
                          height: 7.h,
                        ),
                        Center(
                            child: Text(
                          "what are you waiting for ?".tr(),
                          style: TextStyle(
                              color: isLight ? Colors.black : Colors.white),
                        )),
                        Center(
                            child: Text(
                          "book your trip now.".tr(),
                          style: TextStyle(
                              color: isLight ? Colors.black : Colors.white),
                        )),
                        SizedBox(
                          height: 10.h,
                        )
                      ],
                    ),
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
