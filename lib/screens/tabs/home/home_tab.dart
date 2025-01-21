import 'package:flutter/material.dart';
import 'package:p/screens/home/views/widgets/location_card.dart';
import 'package:p/screens/home/views/widgets/nearby_places.dart';
import 'package:p/screens/home/views/widgets/recommended_places.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),


        children:[
          const SizedBox(
              height: 20),

          const LocationCard(),
          const SizedBox(
              height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              const Text(
                'Recommendation',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              TextButton(
                onPressed:(){},
                style: TextButton.styleFrom(foregroundColor: Colors.black,),
                child: const Text('View All',),
              ),
            ],
          ),

          const SizedBox(
              height: 7),
          const RecommendedPlaces(),

          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nearby',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              TextButton(
                onPressed:(){},
                style: TextButton.styleFrom(foregroundColor: Colors.black,),
                child: const Text('View All',),
              ),
            ],
          ),

          const SizedBox(
              height: 7),
          const NearbyPlaces(),
        ],
      ),
    );
  }
}
