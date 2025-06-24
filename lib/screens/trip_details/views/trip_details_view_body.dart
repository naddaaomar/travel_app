import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/models/inclusion_model.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/company_profile/views/company_profile.dart';
import 'package:p/screens/trip_details/manager/travel_details_cubit.dart';
import 'package:p/screens/trip_details/views/widgets/activities_bottom_sheet.dart';
import 'widgets/trip_on_map.dart';

class TripDetailsViewBody extends StatefulWidget {
  const TripDetailsViewBody({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<TripDetailsViewBody> createState() => _TripDetailsViewBodyState();
}

class _TripDetailsViewBodyState extends State<TripDetailsViewBody> {
  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            TravelDetailsCubit()..getTravelDetails(id: widget.id),
        child: BlocConsumer<TravelDetailsCubit, TravelDetailsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is TravelDetailsLoading) {
              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(
                  color: ColorApp.primaryColor,
                ),
              ));
            }
            if (state is TravelDetailsSuccess) {
              var info = state.travelDetailsModel;
              return Scaffold(
                body: Stack(
                  children: [
                    SizedBox(
                      height: size.height * 0.3,
                      width: double.maxFinite,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20.r)),
                              image: DecorationImage(
                                image: NetworkImage(info.imageUrls![0]),
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
                                        color: isLight
                                            ? Colors.brown
                                            : Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 20.w,
                                      onPressed: () {},
                                      icon: Icon(
                                        Ionicons.heart_outline,
                                        color: isLight
                                            ? Colors.brown
                                            : Colors.white,
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
                        padding:
                            EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInUp(
                                duration: Duration(milliseconds: 1150),
                                child: Row(
                                  children: [
                                    Text(info.title ?? "",
                                        style: TextStyle(
                                            fontFamily: "vol",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17.sp,
                                            color: isLight
                                                ? Colors.black
                                                : Colors.white)),
                                    Spacer(),
                                    Text(
                                      "${info.price} EGP",
                                      style: TextStyle(
                                          fontFamily: "pop",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                          color: isLight
                                              ? Colors.black
                                              : Colors.white),
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
                                          "${info.startDate.toString().substring(0, 10)}",
                                          style: TextStyle(
                                              fontFamily: "pop", fontSize: 10),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text("end date",
                                            style: TextStyle(
                                                fontFamily: "pop",
                                                fontSize: 11)),
                                        Text(
                                            "${info.startDate.toString().substring(0, 10)}",
                                            style: TextStyle(
                                                fontFamily: "pop",
                                                fontSize: 10))
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 4.w),
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CompanyProfile(
                                                      id: info.companyId
                                                          .toString(),
                                                    ),
                                                  ));
                                            },
                                            iconSize: 20.w,
                                            icon: Icon(
                                                Ionicons
                                                    .chatbubble_ellipses_outline,
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
                                                  gradient: LinearGradient(
                                                      colors: [
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
                                                info.availableSeats.toString(),
                                                style: TextStyle(
                                                    fontFamily: "pop",
                                                    fontSize: 10),
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
                                          color: isLight
                                              ? Colors.black
                                              : Colors.white),
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
                                  info.description ?? '',
                                  style: TextStyle(
                                      fontFamily: "pop",
                                      fontSize: 12.sp,
                                      color: isLight
                                          ? Colors.black
                                          : Colors.white),
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
                                          color: isLight
                                              ? Colors.black
                                              : Colors.white),
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
                                  itemCount: info.imageUrls!.length,
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.network(
                                        info.imageUrls![index],
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15,
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
                                        'Destination City '.tr(),
                                        style: TextStyle(
                                            fontFamily: "pop",
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            color: isLight
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FadeInUp(
                                duration: Duration(milliseconds: 2250),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    info.destinationCity ?? "",
                                    style: TextStyle(
                                      fontFamily: "pop",
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
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
                                            color: isLight
                                                ? Colors.black
                                                : Colors.white),
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
                                height: 20,
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
                                          builder: (context) =>
                                              ActivitiesBottomSheet(
                                            itenraries: info.itenraries!,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Activities '.tr(),
                                        style: TextStyle(
                                          fontFamily: "pop",
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: isLight
                                              ? ColorApp.primaryColor
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                                    Text(
                                      'Amenities',
                                      style: TextStyle(
                                        fontFamily: "pop",
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: isLight
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FadeInUp(
                                duration: Duration(milliseconds: 2500),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.w, top: 4.h),
                                  child: Text(
                                    "Enjoy These Features",
                                    style: TextStyle(
                                        fontFamily: "pop",
                                        fontSize: 12,
                                        color: isLight
                                            ? Colors.black
                                            : Colors.white),
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
                                            "${info.amenities![index]}",
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
                                    Text(
                                      'Departure Point: ${info.departurePoint}',
                                      style: TextStyle(
                                        fontFamily: "pop",
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: isLight
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 4,
                              // ),
                              // FadeInUp(
                              //   duration: Duration(milliseconds: 2250),
                              //   child: GestureDetector(
                              //     onTap: () async {
                              //       final url = Uri.parse("https://www.google.com/maps/search/?api=1&query=28.5093,34.5136");
                              //       await launchUrl(url, mode: LaunchMode.externalApplication); // opens outside app safely
                              //     },
                              //
                              //     child: Padding(
                              //       padding: const EdgeInsets.only(left: 20),
                              //       child: Text(
                              //         "View Departure Point: Barcelona Port",
                              //         style: TextStyle(
                              //           fontFamily: "pop",
                              //           fontSize: 11,
                              //           color:
                              //               isLight ? Colors.black : Colors.white,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
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
                                    Text(
                                      'Transportation',
                                      style: TextStyle(
                                        fontFamily: "pop",
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: isLight
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FadeInUp(
                                duration: Duration(milliseconds: 2250),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    info.transportationType ?? "",
                                    style: TextStyle(
                                      fontFamily: "pop",
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
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
                                                builder: (context) =>
                                                    HomeViewBody(),
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
                                      color: isLight
                                          ? Colors.black
                                          : Colors.white),
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
                                      color: isLight
                                          ? Colors.black
                                          : Colors.white),
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
              );
            }
            return Scaffold(
              body: Text("Something went wrong"),
            );
          },
        ),
      ),
    );
  }
}
