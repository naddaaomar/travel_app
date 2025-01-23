import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import '../../../../models/recommended_places.dart';
import '../../../trip_details/views/widgets/trip_details_view_body.dart';

class RecommendedPlaces extends StatelessWidget {
  const RecommendedPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 255,
      child: CarouselSlider(
          items: recommendedPlaces.map((index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: 220,
              child: Card(
                elevation: 10,
                shadowColor: ColorApp.primaryColor,
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
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  'place',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.star,
                                color: Colors.yellow.shade700,
                                size: 14,
                              ),
                              const Text(
                                'rate',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          const Row(
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
                                'location',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
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
    );
  }
}
