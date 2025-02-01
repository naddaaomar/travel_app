import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';
import '../../../../models/recommended_places.dart';
import '../../../trip_details/views/widgets/trip_details_view_body.dart';
import 'dart:ui' as ui;

class RecommendedPlaces extends StatelessWidget {
  const RecommendedPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;

    return SizedBox(
      height: 255,
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: CarouselSlider(
            items: recommendedPlaces.map((index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 220,
                child: Card(
                  color: isLight ? Colors.white : ColorApp.cardColorDark,
                  elevation: 10,
                  shadowColor: isLight
                      ? ColorApp.primaryColor
                      : ColorApp.primaryColorDark,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
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
                      padding: const EdgeInsets.all(7),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                index.image,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                                height: 150,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    'place'.tr(),
                                    style: TextStyle(
                                        fontSize: 15,
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
                                  size: 14,
                                ),
                                Text(
                                  'rate'.tr(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: isLight
                                          ? Colors.black
                                          : Colors.white),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Icon(
                                    Ionicons.location,
                                    color: ColorApp.primaryColor,
                                    size: 16,
                                  ),
                                ),
                                Text(
                                  'location'.tr(),
                                  style: TextStyle(
                                      fontSize: 12,
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
  }
}
