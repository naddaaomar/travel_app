import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';

import '../models/AllTravelsModel.dart';

class AllTravelsCard extends StatelessWidget {
  AllTravelsCard({super.key, required this.allTravelsModel});

  Items allTravelsModel;

  @override
  Widget build(BuildContext context) {
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
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              child: Image.network(
                allTravelsModel.imageUrls![1] ?? "",
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
                  Text(
                    allTravelsModel.title ?? "",
                    style: TextStyle(
                        fontFamily: "pop",
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                  Text(
                    "Company: ${allTravelsModel.companyName}",
                    style: TextStyle(
                        fontFamily: "pop", fontSize: 10, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [Color(0xffCDBBBB), Color(0xffEC8585)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Text(
                          "${allTravelsModel.price.toString()} EGP",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: "pop"),
                        ),
                      ),
                      Spacer(),
                      IconButton(onPressed: () {}, icon: Icon(Ionicons.heart_outline,
                        color: Colors.red,))
                    ],
                  ),
                ],
              ),
            )
          ],
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
        //                   allTravelsModel.address ?? "",
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
