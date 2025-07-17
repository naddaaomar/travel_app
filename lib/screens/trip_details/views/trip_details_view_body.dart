import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/internet_checker/internet_checker_impl.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/models/inclusion_model.dart';
import 'package:p/screens/booking/presentation/pages/booking_screen.dart';
import 'package:p/screens/company_profile/presentation/pages/company_profile.dart';
import 'package:p/screens/events_details/presentation/pages/event_details_view_body.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/trip_details/manager/travel_details_cubit.dart';
import 'package:p/screens/trip_details/views/widgets/activities_bottom_sheet.dart';
import 'package:p/screens/trip_details/views/widgets/fading_images.dart';
import 'package:p/screens/trip_details/views/widgets/included.dart';
import 'package:p/screens/trip_details/views/widgets/not_included.dart';
import 'package:shimmer/shimmer.dart';
import '../../tabs/profile/profile_tabs/favorite_trips_widget/data/service/auth_check.dart';
import '../../tabs/profile/profile_tabs/favorite_trips_widget/presentation/manager/favorites_cubit.dart';
import '../../tabs/profile/profile_tabs/favorite_trips_widget/presentation/manager/favorites_state.dart';
import 'widgets/trip_on_map.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
        TravelDetailsCubit(networkInfo: NetworkInfoImpl(Connectivity()))..getTravelDetails(id: widget.id),
        child: BlocConsumer<TravelDetailsCubit, TravelDetailsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var info = state.travelDetailsModel;
            double? calculateOriginalPrice(
                double? discountedPrice, double? discountPercent) {
              if (discountedPrice == null ||
                  discountPercent == null ||
                  discountPercent == 0) return null;
              return discountedPrice / (1 - discountPercent / 100);
            }
// Favorite button listen to its cubit and match its id with the trip id
            final int tripId = int.tryParse(widget.id) ?? 0;
            final favoritesState = context.watch<FavoritesCubit>().state;

            if (favoritesState is! FavoritesLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            final trip = favoritesState.favorites.firstWhere(
                  (t) => t.id == tripId,
              orElse: () => throw Exception('Trip not found'),
            );
            return Scaffold(
              body: Stack(
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                    width: double.maxFinite,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        FadingImageSlider(
                          imageUrls: info?.imageUrls ?? [],
                          isLoading: state.isLoading,
                        ),
                        Positioned(
                          top: 10.h,
                          left: 0.w,
                          child: FadeIn(
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
                                      color:
                                      isLight ? Colors.brown : Colors.white,
                                    ),
                                  ),
                                  FavoriteButton(
                                    isFavorite: true,
                                    iconSize: 40,
                                    valueChanged: (isFavorite) async {
                                      if (!isFavorite) {
                                        final isAuth = await FavoriteAuth.checkAuth(context);
                                        if (!isAuth) {
                                          FavoriteAuth.showAuthRequiredMessage(context);
                                          return false;
                                        }
                                        try {
                                          await context.read<FavoritesCubit>().removeFavorite(trip.id);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: const Text('Removed from favorites'),
                                              duration: const Duration(seconds: 1),
                                              action: SnackBarAction(
                                                label: 'Undo',
                                                onPressed: () {
                                                  context.read<FavoritesCubit>().addFavorite(trip.id);
                                                },
                                              ),
                                            ),
                                          );
                                          return true;
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Error: ${e.toString()}'),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                          return false;
                                        }
                                      }
                                      return false;
                                    },
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
                      child: state.isLoading
                          ? SingleChildScrollView(
                        child: buildShimmer(
                          height: 25,
                          lines: 30,
                          borderRadius: BorderRadius.circular(10),
                          spacing: 10,
                        ),
                      )
                          : AnimationLimiter(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            AnimationConfiguration.toStaggeredList(
                                duration:
                                const Duration(milliseconds: 650),
                                delay: const Duration(
                                    milliseconds:
                                    100), // Optional: staggering delay
                                childAnimationBuilder: (widget) =>
                                    FadeInAnimation(
                                      // verticalOffset: 60.0, // Starts higher = more magic drop effect
                                      curve: Curves
                                          .easeIn, // Smooth fade & drop
                                      child: FadeInAnimation(
                                        curve: Curves.easeIn,
                                        child: widget,
                                      ),
                                    ),
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start, // Align the title to the left
                                          children: [
                                            Text(
                                              info?.title ?? "",
                                              style: TextStyle(
                                                fontFamily: "vol",
                                                fontWeight:
                                                FontWeight.w500,
                                                fontSize: 18.sp,
                                                color: isLight
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                              overflow: TextOverflow
                                                  .ellipsis, // Handle overflow with ellipsis
                                              maxLines:
                                              2, // Allow the title to use up to two lines
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (info?.saleDiscount == 0) ...[
                                        SizedBox(
                                          width: 20,
                                        ),

                                        Text(
                                          "${(info?.price)?.toStringAsFixed(0)} EGP",
                                          style: TextStyle(
                                            fontFamily: "pop",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            color: isLight
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ),
                                      ] else ...[
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      color: Color(
                                                          0xff811500),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          5)),
                                                  child: Text(
                                                    "-${info?.saleDiscount?.toStringAsFixed(0)}",
                                                    style: TextStyle(
                                                        color:
                                                        Colors.white,
                                                        fontFamily: "pop",
                                                        fontSize: 10),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Shimmer.fromColors(
                                                  baseColor: ColorApp
                                                      .primaryColor,
                                                  highlightColor: Colors
                                                      .grey.shade300,
                                                  period: Duration(
                                                      milliseconds: 2100),
                                                  child: Text(
                                                    "EGP ${info?.price?.toStringAsFixed(0)}",
                                                    style: TextStyle(
                                                      fontFamily: "pop",
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "EGP ${calculateOriginalPrice(info?.price?.toDouble(), info?.saleDiscount?.toDouble())?.toStringAsFixed(0)}",
                                              style: TextStyle(
                                                fontFamily: "pop",
                                                fontSize: 12,
                                                decoration: TextDecoration
                                                    .lineThrough,
                                                decorationColor:
                                                Colors.red,
                                              ),
                                            )
                                          ],
                                        ),
                                      ]
                                    ],
                                  ),
                                  //SizedBox(height: 15,),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "start date",
                                            style: TextStyle(
                                                fontFamily: "pop",
                                                fontSize: 11),
                                          ),
                                          Text(
                                            "${info?.startDate.toString().substring(0, 10)}",
                                            style: TextStyle(
                                                fontFamily: "pop",
                                                fontSize: 10),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text("end date",
                                              style: TextStyle(
                                                  fontFamily: "pop",
                                                  fontSize: 11)),
                                          Text(
                                              "${info?.startDate.toString().substring(0, 10)}",
                                              style: TextStyle(
                                                  fontFamily: "pop",
                                                  fontSize: 10))
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CompanyProfile(
                                                          id: info?.companyId
                                                              .toString() ??
                                                              "",
                                                        ),
                                                  ));
                                            },
                                            child: Icon(
                                              Ionicons
                                                  .chatbubble_ellipses_outline,
                                              color: isLight
                                                  ? Colors.black
                                                  : Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    5),
                                                border: GradientBoxBorder(
                                                    gradient:
                                                    LinearGradient(
                                                        colors: [
                                                          Color(
                                                              0xffFF9884),
                                                          ColorApp
                                                              .thirdColor
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
                                                  info?.availableSeats
                                                      .toString() ??
                                                      "",
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
                                  SizedBox(
                                    height: 20,
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
                                        'Description',
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
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  BlocBuilder<TravelDetailsCubit, TravelDetailsState>(
                                    builder: (context, state) {
                                      final description = state.travelDetailsModel?.description ?? '';
                                      final isExpanded = state.isDescriptionExpanded;
                                      final isLongText = description.length > 100;
                                      final visibleText = isExpanded
                                          ? description
                                          : description.length > 100
                                          ? description.substring(0, 100)
                                          : description;

                                      return Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 15),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: visibleText,
                                                style: TextStyle(
                                                  fontFamily: "pop",
                                                  fontSize: 16.sp,
                                                  color: isLight ? Colors.black : Colors.white,
                                                ),
                                              ),
                                              if (isLongText)
                                                TextSpan(
                                                  text: isExpanded ? " See less" : " ... See more",
                                                  style: TextStyle(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorApp.primaryColor,
                                                  ),
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      context.read<TravelDetailsCubit>().toggleDescriptionExpanded();
                                                    },
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )

                                  ,
                                  if (info?.categoryName != null) ...[
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: isLight
                                                  ? ColorApp.primaryColor
                                                  : ColorApp
                                                  .primaryColorDark,
                                              size: 10.w,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              'Category',
                                              style: TextStyle(
                                                  fontFamily: "pop",
                                                  fontSize: 13.sp,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  color: isLight
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.w,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15),
                                          child: Text(
                                            info?.categoryName ?? '',
                                            style: TextStyle(
                                                fontFamily: "pop",
                                                fontSize: 12.sp,
                                                color: isLight
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
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
                                            fontFamily: "pop",
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            color: isLight
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 20,
                                    ),
                                    itemCount: info?.imageUrls!.length,
                                    itemBuilder: (context, index) {
                                      return ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(10.r),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          info?.imageUrls![index] ??
                                              "",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                                baseColor: ColorApp.baseColor,
                                                highlightColor:
                                                ColorApp.highlightColor,
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  color: ColorApp.baseColor,
                                                ),
                                              ),
                                          errorWidget:
                                              (context, url, error) =>
                                              Image.asset(
                                                'assets/images/no_image.png',
                                                fit: BoxFit.cover,
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.symmetric(
                                  //       vertical: 5.h),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.start,
                                  //     children: [
                                  //       Icon(
                                  //         Icons.circle,
                                  //         color: isLight
                                  //             ? ColorApp.primaryColor
                                  //             : ColorApp.primaryColorDark,
                                  //         size: 10.w,
                                  //       ),
                                  //       SizedBox(
                                  //         width: 5.w,
                                  //       ),
                                  //       Text(
                                  //         'Destination City',
                                  //         style: TextStyle(
                                  //             fontFamily: "pop",
                                  //             fontSize: 13.sp,
                                  //             fontWeight: FontWeight.w500,
                                  //             color: isLight
                                  //                 ? Colors.black
                                  //                 : Colors.white),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding:
                                  //       const EdgeInsets.only(left: 15),
                                  //   child: Text(
                                  //     info?.destinationCity ?? "",
                                  //     style: TextStyle(
                                  //       fontFamily: "pop",
                                  //       fontSize: 12,
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 15.h,
                                  // ),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // Destination City Column
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsets.symmetric(
                                                  vertical: 5.h),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: isLight
                                                        ? ColorApp
                                                        .primaryColor
                                                        : ColorApp
                                                        .primaryColorDark,
                                                    size: 10.w,
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  Text(
                                                    'Destination City',
                                                    style: TextStyle(
                                                      fontFamily: "pop",
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: isLight
                                                          ? Colors.black
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                info?.destinationCity ??
                                                    "",
                                                style: TextStyle(
                                                  fontFamily: "pop",
                                                  fontSize: 12.sp,
                                                  color: isLight
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                                maxLines: 1,
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            ),
                                            TripOnMap(
                                              Latitude:
                                              (info?.destinationCityLat ??
                                                  0)
                                                  .toDouble(),
                                              Longitude:
                                              (info?.destinationCityLng ??
                                                  0)
                                                  .toDouble(),
                                              width: double.infinity,
                                              hight: 150.h,
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 10.w),

                                      // Departure Point Column
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsets.symmetric(
                                                  vertical: 5.h),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: isLight
                                                        ? ColorApp
                                                        .primaryColor
                                                        : ColorApp
                                                        .primaryColorDark,
                                                    size: 10.w,
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  Text(
                                                    'Departure Point',
                                                    style: TextStyle(
                                                      fontFamily: "pop",
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: isLight
                                                          ? Colors.black
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                info?.departurePoint ??
                                                    "",
                                                style: TextStyle(
                                                  fontFamily: "pop",
                                                  fontSize: 12.sp,
                                                  color: isLight
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                                maxLines: 1,
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            ),
                                            TripOnMap(
                                              Latitude:
                                              (info?.departurePointLat ??
                                                  0)
                                                  .toDouble(),
                                              Longitude:
                                              (info?.departurePointLng ??
                                                  0)
                                                  .toDouble(),
                                              width: double.infinity,
                                              hight: 150.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.only(top: 7),
                                  //       child: Icon(
                                  //         Icons.circle,
                                  //         color: isLight
                                  //             ? ColorApp.primaryColor
                                  //             : ColorApp.primaryColorDark,
                                  //         size: 10.w,
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 5.w,
                                  //     ),
                                  //  //   Text(" ${info?.id}"),
                                  //     Expanded(
                                  //       child: Text(
                                  //         'Departure Point: ${info?.departurePoint}',
                                  //         style: TextStyle(
                                  //           fontFamily: "pop",
                                  //           fontSize: 13.sp,
                                  //           fontWeight: FontWeight.w500,
                                  //           color: isLight
                                  //               ? Colors.black
                                  //               : Colors.white,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 15,
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
                                        'Transportation: ${info?.transportationType}',
                                        style: TextStyle(
                                          fontFamily: "pop",
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: isLight
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                      // SizedBox(width: 5,),
                                      // Text(
                                      //   info?.transportationType ?? "",
                                      //   style: TextStyle(
                                      //     fontFamily: "pop",
                                      //     fontSize: 12,
                                      //   ),
                                      // ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 15,
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
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) =>
                                                ActivitiesBottomSheet(
                                                  itenraries:
                                                  info?.itineraries,
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
                                  SizedBox(
                                    height: 15,
                                  ),
                                  if(info?.amenities?.isEmpty==false)...[
                                    Center(
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
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                    SizedBox(
                                      height:
                                      40, // height of each container
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        itemCount: info?.amenities?.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                right: 10.w),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                                vertical: 8.h),
                                            decoration: BoxDecoration(
                                              color: isLight
                                                  ? Color(0xFFEFEFEF)
                                                  : Color(0xFF444444),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.r),
                                              border: Border.all(
                                                color: isLight
                                                    ? ColorApp.primaryColor
                                                    : ColorApp
                                                    .primaryColorDark,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${info?.amenities![index]}",
                                                style: TextStyle(
                                                  fontFamily: "pop",
                                                  fontSize: 11,
                                                  color: isLight
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                  ],

                                  if ((info?.included?.isNotEmpty ??
                                      false)) ...[
                                    SizedBox(height: 15),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) =>
                                              IncludedBottomSheet(
                                                includedItems: info?.included,
                                              ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: isLight
                                                ? ColorApp.primaryColor
                                                : ColorApp
                                                .primaryColorDark,
                                            size: 10.w,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            'Included',
                                            style: TextStyle(
                                              fontFamily: "pop",
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              color: isLight
                                                  ? ColorApp.primaryColor
                                                  : Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                  ],

                                  if ((info?.notIncluded?.isNotEmpty ??
                                      false)) ...[
                                    GestureDetector(
                                      onTap: () {
                                        print(info?.notIncluded);
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) =>
                                              NotIncludedBottomSheet(
                                                notIncludedItems:
                                                info?.notIncluded,
                                              ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: isLight
                                                ? ColorApp.primaryColor
                                                : ColorApp
                                                .primaryColorDark,
                                            size: 10.w,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            'Not Included',
                                            style: TextStyle(
                                              fontFamily: "pop",
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              color: isLight
                                                  ? ColorApp.primaryColor
                                                  : Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],

                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          HomeViewBody.currentIndex = 2;
                                        });

                                        Future.delayed(
                                          Duration(milliseconds: 200),
                                              () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookingScreen(
                                                        model: info!,
                                                      ),
                                                ));
                                            // Navigator.pushReplacement(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           HomeViewBody(),
                                            //     ));
                                          },
                                        );
                                      },
                                      child: Text(
                                        "book Trip".tr(),
                                        style: TextStyle(
                                            fontFamily: "vol",
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

                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Center(
                                      child: Text(
                                        "what are you waiting for ?".tr(),
                                        style: TextStyle(
                                            fontFamily: "vol",
                                            fontSize: 13,
                                            color: isLight
                                                ? Colors.black
                                                : Colors.white),
                                      )),
                                  Center(
                                      child: Text(
                                        "book your trip now.".tr(),
                                        style: TextStyle(
                                            fontFamily: "vol",
                                            fontSize: 13,
                                            color: isLight
                                                ? Colors.black
                                                : Colors.white),
                                      )),
                                  SizedBox(
                                    height: 10.h,
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}