import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              "assets/images/onboard2.png",
              height: 100,
              width: 120,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Dahab",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: ColorApp.primaryColor.withOpacity(.6),
                    size: 18,
                  ),
                  Text(
                    "location",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow[800],
                    size: 18,
                  ),
                  Text(
                    "4.3",
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              )
            ],
          ),
          Spacer(),
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex:10,
                    child: IconButton(
                      iconSize: 18.w,
                      onPressed: () {},
                      icon: FavoriteButton(valueChanged: (_isFavorite) {
                        print('Is Favorite : $_isFavorite');
                      }),
                    ),
                  ),
                  Spacer(),

                  Text("\$200",
                  style: TextStyle(color: ColorApp.primaryColor),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
