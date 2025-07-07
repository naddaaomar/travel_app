import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/remote/models/AllDiscountModel.dart';

class AllDiscountCard extends StatelessWidget {
  AllDiscountCard({super.key, required this.items});

  Items items;

  @override
  Widget build(BuildContext context) {
    final imageUrl = items.coverImageUrl;
    final isValidImageUrl = imageUrl != null &&
        imageUrl.isNotEmpty &&
        Uri.tryParse(imageUrl)?.hasAbsolutePath == true;
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
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: isValidImageUrl
                    ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  width: 140,
                  height: 130,
                  fit: BoxFit.cover,
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
                    "assets/images/no_image.png",
                    width: 140,
                    height: 130,
                    fit: BoxFit.fill,
                  ),
                )
                    : Image.asset(
                  "assets/images/no_image.png",
                  width: 140,
                  height: 130,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      items.title ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: "pop",
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    Text(
                      items.categoryName ?? "",
                      style: TextStyle(
                          fontFamily: "pop",
                          fontSize: 10,

                          color: Colors.black54),
                    ),
                    Text(
                      "${items.companyName}",
                      style: TextStyle(
                          fontFamily: "pop",
                          fontSize: 10,
                          color: Colors.black54),
                    ),
                    Row(
                      children: [
                        Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [Color(0xffCDBBBB), Color(0xffDE8162)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Text(
                            "${items.price.toString()} EGP",
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: "pop"),
                          ),
                        ),
                        Spacer(),
                        Flexible(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: IconButton(
                              iconSize: 18,
                              onPressed: () {},
                              icon: FavoriteButton(valueChanged: (_isFavorite) {
                                print('Is Favorite : $_isFavorite');
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [

      //     Expanded(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Row(
      //             children: [
      //               for (int i = 0; i < fullStars; i++)
      //                 Icon(Icons.star, color: Colors.yellow.shade800, size: 17),
      //               if (fractional >= 0.5)
      //                 Icon(Icons.star_half,
      //                     color: Colors.yellow.shade800, size: 17),
      //               for (int i = 0;
      //               i < emptyStars - (fractional >= 0.5 ? 1 : 0);
      //               i++)
      //                 Icon(Icons.star_border,
      //                     color: Colors.yellow.shade800, size: 17),
      //             ],
      //           ),
      //
      //           SizedBox(
      //             height: 40,
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Icon(
      //                 Icons.location_on_outlined,
      //                 color: ColorApp.primaryColor.withOpacity(.6),
      //                 size: 17,
      //               ),
      //               Expanded(
      //                 child: Text(
      //                   items.address ?? "",
      //                   overflow: TextOverflow.ellipsis,
      //                   style: TextStyle(
      //                       fontSize: 11,
      //                       color: Colors.black54,
      //                       fontFamily: "pop"),
      //                 ),
      //               )
      //             ],
      //           ),
      //           // Rating stars
      //         ],
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
