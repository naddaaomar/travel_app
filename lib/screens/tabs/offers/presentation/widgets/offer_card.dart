import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/models/nearby_places.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';
import 'package:p/screens/trip_details/views/widgets/trip_details_view_body.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      color: Colors.white,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.asset(
                    "assets/images/onboard3.png",
                    width: 150.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  children: [
                    Text(
                      "Place",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      "\$100",
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      "\$200",
                      style: TextStyle(
                          fontSize: 12.sp,
                          decorationThickness: 2,
                          fontWeight: FontWeight.bold,
                          color: ColorApp.primaryColor,
                          decorationColor: ColorApp.primaryColor,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade700,
                  size: 18.w,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade700,
                  size: 18.w,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade700,
                  size: 18.w,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade700,
                  size: 18.w,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade700,
                  size: 18.w,
                ),
                Spacer(),
                Text(
                  "7/07/2025",
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "egypt’s Hidden Gem ,Dahab is a dream come true for thrill-seekers and nature"
              " enthusiasts alike. The town is world-renowned for its diving spots, "
              "particularly the Blue Hole, a bucket-list destination for divers"
              " drawn to its underwater caves and vibrant marine life.",
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 13.sp,
                  color: isLight ? Colors.black.withOpacity(.7) : Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
