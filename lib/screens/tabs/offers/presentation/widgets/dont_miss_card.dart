import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/all_discount_travels/data/remote/models/DiscountItemsModel.dart';
import 'package:p/screens/trip_details/views/trip_details_view_body.dart';
import 'package:p/screens/user_interaction/presentation/manager/interaction_cubit.dart';
import 'package:shimmer/shimmer.dart';

class DontMissCard extends StatelessWidget {
  final DiscountItems? itemsDiscount;
  final bool showShimmer;

  const DontMissCard({
    super.key,
    required this.itemsDiscount,
    this.showShimmer = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.read<InteractionCubit>().trackInteraction(
          contentId: itemsDiscount?.id.toString()??"",
          type: 'travel',
        );


        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TripDetailsViewBody(
                  id: itemsDiscount?.id.toString()??""),
            ));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            showShimmer || itemsDiscount == null
                ? Shimmer.fromColors(
              baseColor: const Color(0xffD8D1CA),
              highlightColor: const Color(0xffCBC0B6),
              child: Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
                : CachedNetworkImage(
              imageUrl: itemsDiscount?.coverImageUrl ?? "",
              height: 170,
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: const Color(0xffD8D1CA),
                highlightColor: const Color(0xffCBC0B6),
                child: Container(
                  height: 170,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/no_image.png",
                height: 170,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 20, color: Colors.orange),
                          const SizedBox(width: 4),
                          showShimmer || itemsDiscount == null
                              ? shimmerLine(width: 100)
                              : SizedBox(
                            width:
                            //230
                            200,
                            child: Text(
                              itemsDiscount!.title ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "pop",
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          showShimmer || itemsDiscount == null
                              ? shimmerLine(width: 24)
                              : Text(
                            "${(itemsDiscount!.saleDiscount! ).toInt()}%",
                            style: TextStyle(
                              fontFamily: "pop",
                              color: ColorApp.primaryColor,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text("🔥", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: showShimmer || itemsDiscount == null
                        ? shimmerLine(width: 100)
                        : Text(
                      itemsDiscount!.companyName ?? "",
                      style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "pop",
                        fontSize: 13,
                      ),
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

  Widget shimmerLine({required double width}) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffD8D1CA),
      highlightColor: const Color(0xffCBC0B6),
      child: Container(
        height: 12,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}