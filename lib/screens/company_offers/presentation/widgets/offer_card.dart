import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';

class OfferCard extends StatelessWidget {
   OfferCard({Key? key, required this.companyOffersModel}) : super(key: key);
  final Items? companyOffersModel;
  //bool isLoading;

// setState
  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 20.w),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                    child: Image.network(
                      companyOffersModel?.coverImageUrl ?? "",
                      width: 150.w,
                      height: 130,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/no_image.png",
                          width: 150.w,
                          height: 130,
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: 10, left: 5, top: 10, bottom: 15),
                    decoration: BoxDecoration(
                        color: Color(0xff811500),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(60),
                        )),
                    child: Text(
                      "-${((companyOffersModel?.saleDiscount)! * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                          fontFamily: "pop",
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: SizedBox(
                  height: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        companyOffersModel?.title ?? "",
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "pop"),
                      ),
                      Text(
                        companyOffersModel?.categoryName ?? "",
                        style: TextStyle(fontFamily: "pop", fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: ColorApp.primaryColor.withOpacity(.7),
                            size: 17,
                          ),
                          Expanded(
                            child: Text(
                              companyOffersModel?.destinationCity ?? "",
                              style: TextStyle(fontSize: 10, fontFamily: "pop"),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 10,
                        child: FavoriteButton(valueChanged: (_isFavorite) {
                          print('Is Favorite : $_isFavorite');
                        }),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "EGP ${companyOffersModel?.price}",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "pop",
                                decorationThickness: 2,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                decorationColor: Colors.red,
                                decoration: TextDecoration.lineThrough),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: const [
                                  Color(0xffE2A093),
                                  ColorApp.primaryColor
                                ],
                              ),
                            ),
                            child: Text(
                              "EGP ${companyOffersModel?.baseCost}",
                              style: TextStyle(
                                fontFamily: "pop",
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
