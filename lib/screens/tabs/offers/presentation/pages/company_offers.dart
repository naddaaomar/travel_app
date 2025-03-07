import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/app_bar/app_bar_widget.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/screens/home/views/widgets/nearby_places.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/offers/presentation/pages/offers_screen.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/companies.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/company_card.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/offer_card.dart';
import 'package:p/screens/trip_details/trip_details_view.dart';
import 'package:p/screens/trip_details/views/widgets/trip_details_view_body.dart';

import '../../../../../models/nearby_places.dart';

class CompanyOffers extends StatelessWidget {
  CompanyModel companyModel;
  CompanyOffers({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorApp.primaryColor,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 30.w,
                    ),
                  ),
                  Expanded(
                    child: FadeInUp(
                      child: Text(
                        companyModel.label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 48.w),
                ],
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 110),
                    decoration: BoxDecoration(
                      color: ColorApp.secondaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.r),
                        topLeft: Radius.circular(20.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          LiveList(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            showItemInterval: Duration(milliseconds: 150),
                            showItemDuration: Duration(milliseconds: 350),
                            reAnimateOnVisibility: false,
                            scrollDirection: Axis.vertical,
                            itemBuilder: animationItemBuilder(
                              (index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TripDetailsViewBody(
                                        image: "assets/images/onboard3.png",
                                      ),
                                    ),
                                  );
                                },
                                child: OfferCard(),
                              ),
                            ),
                            itemCount: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CompanyCard()
          ],
        ),
      ),
    );
  }
}
