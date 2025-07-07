import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';

class TravelCard extends StatelessWidget {
  final Items items;

  const TravelCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM, yyyy');
    final startDate = items.startDate != null
        ? dateFormat.format(DateTime.parse(items.startDate!))
        : '';
    final endDate = items.endDate != null
        ? dateFormat.format(DateTime.parse(items.endDate!))
        : '';

    return SizedBox(
      height: 110.h,
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
                items.coverImageUrl ?? "",
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
            SizedBox(width: 10.w),

            // Info Text
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ Space out children vertically
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items.title ?? '',
                      style: TextStyle(
                        fontFamily: "pop",
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 14.sp, color: ColorApp.primaryColor),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            items.destinationCity ?? '',
                            style: TextStyle(
                              fontFamily: "pop",
                              fontSize: 12.sp,
                              color: Colors.grey[700],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.directions_bus, size: 14.sp, color: Colors.grey),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            items.departurePoint ?? '',
                            style: TextStyle(
                              fontFamily: "pop",
                              fontSize: 11.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    // Text(
                    //   "$startDate - $endDate",
                    //   style: TextStyle(
                    //     fontFamily: "pop",
                    //     fontSize: 11.sp,
                    //     color: Colors.black.withOpacity(0.6),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),


            // Favorite + Price
            SizedBox(width: 8.w),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 5),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FavoriteButton(
                    iconSize: 40.sp,
                    isFavorite: false,
                    valueChanged: (_) {},
                  ),
                  SizedBox(height: 15,),
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
            ),
          ],
        ),
      ),
    );
  }
}
