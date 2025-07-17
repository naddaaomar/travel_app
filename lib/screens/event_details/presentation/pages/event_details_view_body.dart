import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/di.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/event_details/presentation/manager/event_details_cubit.dart';
import 'package:p/screens/events_details/presentation/widgets/event_on_map.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class EventDetailsViewBody extends StatefulWidget {
  const EventDetailsViewBody({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<EventDetailsViewBody> createState() => _TripDetailsViewBodyState();
}

class _TripDetailsViewBodyState extends State<EventDetailsViewBody> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    //  final favorites = FavoriteManager().favoritesNotifier.value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
      getIt<EventDetailsCubit>()..getDetails(id: widget.id),
      child: BlocConsumer<EventDetailsCubit, EventDetailsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var info = state.detailsModel;
          var cubit = EventDetailsCubit.get(context);
          final mapLink =
              "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d52517.594734037535!2d31.180523146180434!3d30.05946546726634!2m3...";
          final result = extractLatLngFromEmbedUrl(mapLink);
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    height: size.height * 0.35,
                    width: double.maxFinite,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        state.isLoading && state.detailsModel == null
                            ? Shimmer.fromColors(
                          baseColor: ColorApp.baseColor,
                          highlightColor: ColorApp.highlightColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20.r)),
                              color:
                              Colors.grey[300], // Placeholder color
                            ),
                            height: 200
                                .h, // Adjust height to match your design
                            width: double.infinity,
                          ),
                        )
                            : FadeIn(
                          duration: Duration(milliseconds: 1200),
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20.r)),
                            child: CachedNetworkImage(
                              imageUrl: info?.image ?? "",
                              height: 1000.h,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              placeholder: (context, url) =>
                                  Shimmer.fromColors(
                                    baseColor: Color(0xff9A8C7F),
                                    highlightColor: ColorApp.highlightColor,
                                    child: Container(
                                      height: 200.h,
                                      width: double.infinity,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                              errorWidget: (context, url, error) =>
                                  Container(
                                    height: 200.h,
                                    width: double.infinity,
                                    color: Colors.grey,
                                    child: Icon(Icons.broken_image),
                                  ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10.h,
                          left: 0.w,
                          child: Container(
                            decoration: BoxDecoration(
                              color: isLight
                                  ? Colors.white.withOpacity(0.7)
                                  : ColorApp.cardColorDark.withOpacity(.7),
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(15.r)),
                            ),
                            child: FadeIn(
                              duration: Duration(milliseconds: 1000),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    iconSize: 20.w,
                                    icon: Icon(
                                      Ionicons.chevron_back,
                                      color:
                                      isLight ? Colors.brown : Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    iconSize: 18.w,
                                    onPressed: () {
                                      // ValueListenableBuilder<List<String>>(
                                      //   valueListenable:
                                      //       FavoriteManager().favoritesNotifier,
                                      //   builder: (context, favorites, _) {
                                      //     return FavoriteButton(
                                      //       iconSize: 30,
                                      //       valueChanged: (isFavorite) {
                                      //         FavoriteManager()
                                      //             .toggleFavorite('', context);
                                      //       },
                                      //     );
                                      //   },
                                      // );
                                    },
                                    icon: Icon(Ionicons.heart),
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
                            topRight: Radius.circular(30.r),
                            topLeft: Radius.circular(30.r))),
                    child: Padding(
                      padding:
                      EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: state.isLoading &&
                                      state.detailsModel == null
                                      ? buildShimmer(
                                    height: 20.h,
                                    lines: 2,
                                    spacing: 6.h,
                                    borderRadius:
                                    BorderRadius.circular(4.r),
                                  )
                                      : FadeIn(
                                    duration:
                                    Duration(milliseconds: 1200),
                                    child: Text(
                                      info?.title ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                        fontFamily: "vol",
                                        color: isLight
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            state.isLoading
                                ? buildShimmer(
                              height: 25,
                              lines: 10,
                              borderRadius: BorderRadius.circular(10),
                              spacing: 10,
                            )
                                : Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                if (info?.description != null) ...[
                                  FadeIn(
                                    duration:
                                    Duration(milliseconds: 1450),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: isLight
                                              ? ColorApp.primaryColor
                                              : ColorApp.primaryColorDark,
                                          size: 10.w,
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          'Description',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "pop",
                                            color: isLight
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.w),
                                  BlocBuilder<EventDetailsCubit,
                                      EventDetailsState>(
                                    builder: (context, state) {
                                      final info = state.detailsModel;
                                      final isExpanded =
                                          state.isDescriptionExpanded;
                                      final description =
                                          info?.description ?? "";

                                      final showSeeMore =
                                          description.length > 300;
                                      final displayText =
                                      !isExpanded && showSeeMore
                                          ? description.substring(
                                          0, 250) +
                                          '... '
                                          : description;

                                      return FadeIn(
                                        duration:
                                        Duration(milliseconds: 1750),
                                        child: RichText(
                                          text: TextSpan(
                                            text: displayText,
                                            style: TextStyle(
                                              fontSize: 15.5.sp,
                                              fontFamily: "pop",
                                              color: isLight
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            children: showSeeMore
                                                ? [
                                              TextSpan(
                                                text: isExpanded
                                                    ? ' Show less'
                                                    : ' See more',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  color: isLight
                                                      ? ColorApp
                                                      .primaryColor
                                                      : ColorApp
                                                      .primaryColorDark,
                                                ),
                                                recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap = () {
                                                    context
                                                        .read<
                                                        EventDetailsCubit>()
                                                        .toggleDescriptionExpansion();
                                                  },
                                              ),
                                            ]
                                                : [],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(
                              height: (info?.description != null) ? 15.h : 0,
                            ),
                            if (state.isLoading)
                              buildShimmer(
                                height: 25,
                                lines: 10,
                                borderRadius: BorderRadius.circular(10),
                                spacing: 10,
                              )
                            else if (info != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 📌 Dates
                                  if (info.dates != null ||
                                      info.date != null) ...[
                                    FadeIn(
                                      duration: Duration(milliseconds: 2050),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: isLight
                                                ? ColorApp.primaryColor
                                                : ColorApp.primaryColorDark,
                                            size: 10.w,
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            'Date',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              color: isLight
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontFamily: "pop",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    FadeIn(
                                      duration: Duration(milliseconds: 2350),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.calendar_today,
                                              size: 16.sp,
                                              color: ColorApp.primaryColor),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            // ✅ This allows the text to wrap instead of overflowing
                                            child: Text(
                                              info.dates ?? info.date ?? "",
                                              style: TextStyle(
                                                fontSize: 12.5.sp,
                                                fontFamily: "pop",
                                                color: isLight
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],

                                  SizedBox(height: 12.h),
                                  // 📌 Category
                                  if (info.category != null) ...[
                                    FadeIn(
                                      duration: Duration(milliseconds: 2650),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: isLight
                                                ? ColorApp.primaryColor
                                                : ColorApp.primaryColorDark,
                                            size: 10.w,
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            'Category',
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: isLight
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontFamily: "pop"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FadeIn(
                                      duration: Duration(milliseconds: 2950),
                                      child: Text(
                                        info.category!,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "pop",
                                            color: Colors.black),
                                      ),
                                    )
                                  ],
                                  SizedBox(height: 15.h),

                                  // 📌 Location
                                  if (info.location != null) ...[
                                    FadeIn(
                                      duration: Duration(milliseconds: 3250),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: isLight
                                                ? ColorApp.primaryColor
                                                : ColorApp.primaryColorDark,
                                            size: 10.w,
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            'Location',
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: isLight
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontFamily: "pop"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FadeIn(
                                      duration: Duration(milliseconds: 3550),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.location_on,
                                              size: 16.sp,
                                              color: ColorApp.primaryColor),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Text(
                                              info.location!,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: isLight
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                  SizedBox(height: 12.h),

                                  // 📌 External Link
                                  if (info.link != null &&
                                      info.link!.isNotEmpty)
                                    FadeIn(
                                      duration: Duration(milliseconds: 3850),
                                      child: InkWell(
                                        onTap: () => launchURL(info.link!),
                                        child: Row(
                                          children: [
                                            Icon(Icons.link,
                                                color: ColorApp.primaryColor),
                                            SizedBox(width: 5.w),
                                            Text(
                                              "Open event page",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: ColorApp.primaryColor,
                                                decorationColor:
                                                ColorApp.primaryColor,
                                                decoration:
                                                TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  SizedBox(height: 20.h),

                                  // 📌 Map
                                  if (info.mapLink != null &&
                                      info.mapLink!.isNotEmpty) ...[
                                    FadeIn(
                                      duration: Duration(milliseconds: 4150),
                                      child: Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 5.h),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.map,
                                              color: isLight
                                                  ? ColorApp.primaryColor
                                                  : ColorApp.primaryColorDark,
                                              size: 16.sp,
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              'Show on Map'.tr(),
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: isLight
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    if (result != null)
                                      FadeIn(
                                        duration: Duration(milliseconds: 4450),
                                        child: EventOnMap(
                                          Latitude: result['lat']!,
                                          Longitude: result['lng']!,
                                          width: double.infinity,
                                          hight: 200.h,
                                        ),
                                      ),
                                    SizedBox(height: 20.h),
                                    FadeIn(
                                      duration: Duration(milliseconds: 4750),
                                      child: Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              HomeViewBody.currentIndex = 2;
                                            });

                                            // Future.delayed(
                                            //   Duration(milliseconds: 200),
                                            //       () {
                                            //     Navigator.pushReplacement(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //           builder: (context) => ViewAllEvents(),
                                            //         ));
                                            //   },
                                            // );
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
                                                color: Colors.white, fontSize: 17.sp),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                    FadeIn(
                                      duration: Duration(milliseconds: 5050),
                                      child: Center(
                                          child: Text(
                                            "what are you waiting for ?".tr(),
                                            style: TextStyle(
                                                color: isLight ? Colors.black : Colors.white),
                                          )),
                                    ),
                                    FadeIn(
                                      duration: Duration(milliseconds: 5050),
                                      child: Center(
                                          child: Text(
                                            "discover more.".tr(),
                                            style: TextStyle(
                                                color: isLight ? Colors.black : Colors.white),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    )
                                  ]
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildShimmer({
  required double height,
  int lines = 1,
  double spacing = 8,
  BorderRadius borderRadius = BorderRadius.zero,
  double minWidthFactor = 0.5,
  double maxWidthFactor = 1.0,
}) {
  final random = Random();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(lines, (index) {
      double randomWidthFactor = minWidthFactor +
          random.nextDouble() * (maxWidthFactor - minWidthFactor);

      return Padding(
        padding: EdgeInsets.only(bottom: index == lines - 1 ? 0 : spacing),
        child: Shimmer.fromColors(
          baseColor: ColorApp.baseColor,
          highlightColor: ColorApp.highlightColor,
          child: FractionallySizedBox(
            widthFactor: randomWidthFactor,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: borderRadius,
              ),
            ),
          ),
        ),
      );
    }),
  );
}

Future<void> launchURL(String url) async {
  try {
    final Uri uri = Uri.parse(url.trim());

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      debugPrint('❌ Cannot launch URL: $url');
    }
  } catch (e) {
    debugPrint('❌ Exception occurred while launching URL: $e');
  }
}

Map<String, double>? extractLatLngFromEmbedUrl(String embedUrl) {
  final regex = RegExp(r'!2d([0-9.]+)!3d([0-9.]+)');
  final match = regex.firstMatch(embedUrl);

  if (match != null && match.groupCount == 2) {
    final lng = double.tryParse(match.group(1)!);
    final lat = double.tryParse(match.group(2)!);

    if (lat != null && lng != null) {
      return {'lat': lat, 'lng': lng};
    }
  }

  return null;
}