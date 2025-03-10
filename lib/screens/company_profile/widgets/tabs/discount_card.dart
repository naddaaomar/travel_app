import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../helpers/themes/colors.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key});

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
              height: 105,
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
            height: 105,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Ionicons.heart_outline,
                        color: Colors.red,

                      )),

                  Text(
                    "\$200",
                    style: TextStyle(
                      fontSize: 12,
                        color: Colors.black87,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red),
                  ),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(colors: [
                          Color(0xffE2A093),
                          ColorApp.primaryColor
                        ])),
                    child: Text(
                      "\$100",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 7,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
