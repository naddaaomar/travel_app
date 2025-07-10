import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/NewestModel.dart';


class NewestCard extends StatelessWidget {
  final Items newest;

  NewestCard({super.key, required this.newest});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM, yyyy');
    final startDate = newest.startDate != null
        ? dateFormat.format(DateTime.parse(newest.startDate!))
        : '';
    final endDate = newest.endDate != null
        ? dateFormat.format(DateTime.parse(newest.endDate!))
        : '';

    return SizedBox(
      height: 110,
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trip Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(
                newest.coverImageUrl ?? "",
                width: 110.w,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  "assets/images/no_image.png",
                  width: 110.w,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Trip Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newest.title ?? "",
                    style: TextStyle(fontFamily: "pop",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),

                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 16.sp, color: ColorApp.primaryColor),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          newest.destinationCity ?? '',
                          style: TextStyle(fontFamily: "pop",
                            fontSize: 13.sp,
                            color: Colors.grey[700],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  Row(
                    children: [
                      Icon(Icons.directions_bus,
                          size: 16.sp, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          newest.departurePoint ?? '',
                          style: TextStyle(fontFamily: "pop",fontSize: 12.sp),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Text(
                  //   "$startDate - $endDate",
                  //   style: TextStyle(fontFamily: "pop",
                  //     fontSize: 12.sp,
                  //     color: Colors.black.withOpacity(0.6),
                  //   ),
                  // ),
                ],
              ),
            ),

            // Price + Favorite
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FavoriteButton(
                  iconSize: 30.sp,
                  isFavorite: false,
                  valueChanged: (_) {},
                ),
                SizedBox(height: 15.h),
                Text(
                  "${newest.price} EGP",
                  style: TextStyle(fontFamily: "pop",
                    color: ColorApp.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}