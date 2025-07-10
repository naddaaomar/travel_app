import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/models/AllCompaniesModel.dart';

class AllCompaniesCard extends StatelessWidget {
  AllCompaniesCard({super.key, required this.allCompaniesModel});
  Items allCompaniesModel;

  @override
  Widget build(BuildContext context) {
    double rating = (allCompaniesModel.rating ?? 0.0).toDouble();

    int fullStars = rating.floor();
    int emptyStars = 5 - fullStars;
    double fractional = rating - fullStars;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 4,
                spreadRadius: 3,
                offset: Offset(0, 3))
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            child: CachedNetworkImage(
              imageUrl: allCompaniesModel.profileImageUrl ?? "",
              width: 140,
              height: 130,
              fit: BoxFit.fill,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: const Color(0xffD8D1CA),
                highlightColor: const Color(0xffCBC0B6),
                child: Container(
                  width: 140,
                  height: 130,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/no_image.png',
                width: 140,
                height: 130,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  allCompaniesModel.companyName ?? "",
                  style: TextStyle(
                      fontFamily: "pop",
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                ),
                Row(
                  children: [
                    for (int i = 0; i < fullStars; i++)
                      Icon(Icons.star, color: Colors.yellow.shade800, size: 17),
                    if (fractional >= 0.5)
                      Icon(Icons.star_half,
                          color: Colors.yellow.shade800, size: 17),
                    for (int i = 0;
                    i < emptyStars - (fractional >= 0.5 ? 1 : 0);
                    i++)
                      Icon(Icons.star_border,
                          color: Colors.yellow.shade800, size: 17),
                  ],
                ),

                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: ColorApp.primaryColor.withOpacity(.6),
                      size: 17,
                    ),
                    Expanded(
                      child: Text(
                        allCompaniesModel.address ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                            fontFamily: "pop"),
                      ),
                    )
                  ],
                ),
                // Rating stars
              ],
            ),
          )
        ],
      ),
    );
  }
}