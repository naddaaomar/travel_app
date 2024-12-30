import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/models/nearby_places.dart';
import '../../../trip_details/views/widgets/trip_details_view_body.dart';

class NearbyPlaces extends StatelessWidget {
  const NearbyPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(nearbyPlaces.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom:6),
          child: SizedBox(
            height: 120,
            width: double.maxFinite,

            child: Card(
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TripDetailsViewBody(
                          image: nearbyPlaces[index].image,
                        ),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          nearbyPlaces[index].image,
                          height: double.maxFinite,
                          width: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                      
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'place',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),

                            const Text('company'),
                            const SizedBox(height: 10),
                            const Spacer(),

                            Row(
                              children: [
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
                                ),

                                const Spacer(),

                                RichText(
                                  text: const TextSpan(
                                      style: TextStyle(
                                        fontSize: 16,
                                          color: ColorApp.primaryColor,
                                      ),

                                      text: "\$200 ",
                                      children: [
                                        TextSpan(
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                            text: "/ Person")
                                      ]),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
