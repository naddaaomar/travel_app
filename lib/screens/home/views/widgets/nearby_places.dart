import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/models/nearby_places.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';
import 'package:p/screens/trip_details/views/widgets/trip_details_view_body.dart';

class NearbyPlaces extends StatelessWidget {
  const NearbyPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;

    return Column(
      children: List.generate(nearbyPlaces.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom:6),
          child: SizedBox(
            height: 120,
            width: double.maxFinite,

            child: Card(
              color: isLight?Colors.white:ColorApp.cardColorDark,
              elevation: 10,

              shadowColor: isLight?ColorApp.primaryColor:ColorApp.primaryColorDark,
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
                             Text(
                              'place'.tr(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isLight?Colors.black:Colors.white
                              ),
                            ),
                            const SizedBox(height: 2),

                             Text('company'.tr(),style: TextStyle(color: isLight?Colors.black:Colors.white),),
                            const SizedBox(height: 10),
                            const Spacer(),

                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow.shade700,
                                  size: 14,
                                ),
                                 Text(
                                  'rate'.tr(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isLight?Colors.black:Colors.white
                                  ),
                                ),

                                const Spacer(),

                                RichText(
                                  text:  TextSpan(
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isLight?ColorApp.primaryColor:Colors.white,
                                      ),

                                      text: "\$200",
                                      children: [
                                        TextSpan(
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:isLight? Colors.black54:Colors.white,
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
