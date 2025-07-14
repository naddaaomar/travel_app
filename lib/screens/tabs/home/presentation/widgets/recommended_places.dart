import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/ai/Ai_requests.dart';
import 'package:p/screens/event_details/presentation/pages/event_details_view_body.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/home/presentation/manager/home_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:ui' as ui;

class RecommendedPlaces extends StatelessWidget {
  RecommendedPlaces({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var info = state.eventsModel;

        return SizedBox(
          height: 288.h,
          child: Directionality(
            textDirection: ui.TextDirection.ltr,
            child: CarouselSlider(
                items: (state.isLoading
                    ? List.generate(4, (_) => null)
                    : info ?? [])
                    .map((event) {
                  final fullDate = event?.dates ?? event?.date ?? '';
                  final match = RegExp(r'^.*?\d{4}').stringMatch(fullDate);
                  String getGovernorateFromLocation(String location) {
                    const cities = [
                      "Cairo",
                      "Alexandria",
                      "Giza",
                      "Ismailia",
                      "Hurghada",
                      "Port Said",
                      "Aswan",
                      "Luxor",
                      "Mansoura",
                      "Tanta",
                      "Zagazig",
                      "Suez",
                      "Fayoum",
                      "Qena",
                    ];

                    for (final city in cities) {
                      if (location.toLowerCase().contains(city.toLowerCase())) {
                        return city;
                      }
                    }

                    // Fallback: try to get second-to-last non-numeric part
                    final parts = location.split(',');
                    for (int i = parts.length - 1; i >= 0; i--) {
                      final part = parts[i].trim();
                      // Return the first non-numeric and non-"Egypt" part
                      if (part.isNotEmpty &&
                          !RegExp(r'^\d+$').hasMatch(part) &&
                          part.toLowerCase() != "egypt") {
                        return part;
                      }
                    }

                    // Final fallback
                    return "Location";
                  }

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
                        onTap: () async {
                          final aiRequests = AiRequests(); // no arguments now

                          await aiRequests.trackInteractionClick(
                            contentId: event!.id.toString(),
                            type: 'event',
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailsViewBody(
                                id: event!.id.toString(),
                              ),
                            ),
                          );
                        }
                        ,
                        child: Padding(
                          padding: EdgeInsets.all(7.w),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                state.isLoading || event == null
                                    ? Shimmer.fromColors(
                                  baseColor: const Color(0xffD8D1CA),
                                  highlightColor: const Color(0xffCBC0B6),
                                  child: Container(
                                    height: 164.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,

                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                  ),
                                ):ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FadeIn(duration: Duration(milliseconds: 400),
                                    child: CachedNetworkImage(
                                      imageUrl: event?.image ?? "",
                                      width: double.maxFinite,
                                      fit: BoxFit.cover,
                                      height: 164.h,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                            baseColor: const Color(0xffD8D1CA),
                                            highlightColor:
                                            const Color(0xffCBC0B6),
                                            child: Container(
                                              height: 164.h,
                                              width: double.infinity,

                                              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                            'assets/images/no_image.png',
                                            width: double.maxFinite,
                                            fit: BoxFit.cover,
                                            height: 164.h,
                                          ),
                                    ),
                                  ),
                                )
                                ,
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: state.isLoading ||
                                            event ==
                                                null // <-- replace with your actual loading state
                                            ? Shimmer.fromColors(
                                          baseColor: ColorApp
                                              .baseColor, // set your base color
                                          highlightColor: ColorApp
                                              .highlightColor, // set your highlight color
                                          child: Container(
                                            height: 14
                                                .h, // or adjust based on design
                                            width: double.infinity,
                                            decoration: BoxDecoration(color: Colors.grey[
                                            300],borderRadius: BorderRadius.circular(10)),

                                            // just a solid placeholder
                                          ),
                                        )
                                            : FadeIn(duration: Duration(milliseconds: 400),
                                          child: Text(
                                            event?.title ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontFamily: "pop",
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: isLight
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    //  const Spacer(),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.date_range_rounded,
                                      color: ColorApp.primaryColor,
                                      size: 14.w,
                                    ),
                                    SizedBox(width: 7),
                                    state.isLoading ||
                                        event ==
                                            null // <-- replace with your actual loading state
                                        ? Shimmer.fromColors(
                                      baseColor: ColorApp
                                          .baseColor, // your custom base color
                                      highlightColor: ColorApp
                                          .highlightColor, // your custom highlight color
                                      child: Container(
                                        height: 10.h,
                                        width: 60
                                            .w,
                                        decoration: BoxDecoration(     color: Colors.grey[300],borderRadius: BorderRadius.circular(10)),


                                      ),
                                    )
                                        : FadeIn(duration: Duration(milliseconds: 400),
                                      child: Text(
                                        match ?? "",
                                        style: TextStyle(
                                          fontFamily: "pop",
                                          fontSize: 11.sp,
                                          color: isLight
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
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
                                    state.isLoading ||
                                        event ==
                                            null // <-- replace with your actual loading state
                                        ? Shimmer.fromColors(
                                      baseColor: ColorApp
                                          .baseColor, // your custom base color
                                      highlightColor: ColorApp
                                          .highlightColor, // your custom highlight color
                                      child: Container(
                                        height: 10.h,
                                        decoration: BoxDecoration( color: Colors.grey[300],borderRadius: BorderRadius.circular(10)),

                                        width: 60
                                            .w, // adjust width as needed

                                      ),
                                    )
                                        : FadeIn(duration: Duration(milliseconds: 400),
                                      child: Text(
                                        getGovernorateFromLocation(
                                            event?.location ?? ""),
                                        style: TextStyle(
                                          fontFamily: "pop",
                                          fontSize: 11.sp,
                                          color: isLight
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
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
                  autoPlay: !state.isLoading,
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