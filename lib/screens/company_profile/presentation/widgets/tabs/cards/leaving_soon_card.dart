import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';

class LeavingSoonCard extends StatelessWidget {
  final Items items;

  const LeavingSoonCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM, yyyy');
    final startDate = items.startDate != null
        ? dateFormat.format(DateTime.parse(items.startDate??""))
        : '';
    final endDate = items.endDate != null
        ? dateFormat.format(DateTime.parse(items.endDate??""))
        : '';

    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trip Image
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(
                items.coverImageUrl ?? '',
                height: 100.h,
                width: 120.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  "assets/images/no_image.png",
                  height: 100.h,
                  width: 120.w,
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
                  // Title
                  Text(
                    items.title ?? '',
                    style: TextStyle(
                      fontFamily: "pop",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 16.sp, color: ColorApp.primaryColor),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          items.destinationCity ?? '',
                          style: TextStyle(
                            fontFamily: "pop",
                            fontSize: 13.sp,
                            color: Colors.grey[700],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Departure
                  Row(
                    children: [
                      Icon(Icons.departure_board,
                          size: 16.sp, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          items.departurePoint ?? '',
                          style: TextStyle(
                            fontFamily: "pop",
                            fontSize: 12.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Dates
                  Text(
                    "$startDate - $endDate",
                    style: TextStyle(
                      fontFamily: "pop",
                      fontSize: 12.sp,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),

                  // Urgent badge (optional)
                  SizedBox(height: 6.h),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      "Hurry up! Few days left",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Favorite + Price
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
                  "${items.price} EGP",
                  style: TextStyle(
                    fontFamily: "pop",
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