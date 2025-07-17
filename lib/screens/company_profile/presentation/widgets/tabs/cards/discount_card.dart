import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';

class DiscountCard extends StatelessWidget {
  final Items items;

  const DiscountCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    double? calculateOriginalPrice(double? discountedPrice, double? discountPercent) {
      if (discountedPrice == null || discountPercent == null || discountPercent == 0) return null;
      return discountedPrice / (1 - discountPercent / 100);
    }

    return SizedBox(
      height: 110,
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    items.title ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: "pop",
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: ColorApp.primaryColor.withOpacity(.6),
                        size: 18,
                      ),
                      Flexible(
                        child: Text(
                          items.departurePoint ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontFamily: "pop", fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.directions_bus_filled,
                        color: Colors.grey[600],
                        size: 18,
                      ),
                      Text(
                        items.transportationType ?? '',
                        style: const TextStyle(fontFamily: "pop", fontSize: 11),
                      ),
                    ],
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 12, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: FavoriteButton(
                      iconSize: 40.sp,
                      isFavorite: false,
                      valueChanged: (_) {},
                    ),
                  ),
                  Text(
                    "${calculateOriginalPrice(items?.price?.toDouble(), items?.saleDiscount?.toDouble())?.toStringAsFixed(0)} EGP",
                    style: const TextStyle(
                      fontFamily: "pop",
                      fontSize: 12,
                      color: Colors.black87,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Color(0xffE2A093), ColorApp.primaryColor],
                      ),
                    ),
                    child: Text(
                      "${items.price?.toStringAsFixed(0) ?? 0} EGP",
                      style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
