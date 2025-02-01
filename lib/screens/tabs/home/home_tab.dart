import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/home/views/widgets/location_card.dart';
import 'package:p/screens/home/views/widgets/nearby_places.dart';
import 'package:p/screens/home/views/widgets/recommended_places.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          const LocationCard(),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'recommendation'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: isLight?Colors.black:Colors.white
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: Text(
                  'view All'.tr(),
                  style: TextStyle(color:isLight?Colors.black:Colors.white),

                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          const RecommendedPlaces(),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'nearby'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                   color: isLight?Colors.black:Colors.white
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: Text(
                  'view All'.tr(),
                  style: TextStyle(color: isLight?Colors.black:Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          const NearbyPlaces(),
        ],
      ),
    );
  }
}
