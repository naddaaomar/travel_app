import 'package:auto_animated/auto_animated.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/offers/presentation/pages/company_offers.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/companies.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/hot_deals.dart';
import 'dart:ui' as ui;
class OffersScreen extends StatelessWidget {
   OffersScreen({super.key});

  var company = CompanyModel.Companies();

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(right: 10.w, top: 0.h),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                      width: 94.w,
                      height: 40.h,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "don't miss".tr(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                  color: isLight ? Colors.black : Colors.white),
            ),
            SizedBox(
              height: 15.h,
            ),
            HotDeals(),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "discover exclusive offers \nfrom top companies tailored just for you"
                  .tr(),
              maxLines: 2,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isLight ? Colors.black : Colors.white),
            ),
            LiveGrid(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              visibleFraction: 0.001,
              showItemInterval: Duration(milliseconds: 80),
              showItemDuration: Duration(milliseconds: 150),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 30, mainAxisSpacing: 0),
              itemBuilder: animationItemBuilder((index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompanyOffers(
                              companyModel: company[index],
                            ),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 27.h),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: Image.asset(
                              company[index].imagePath,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: Color.fromARGB(130, 128, 128, 128),
                            ),
                            height: double.infinity,
                          ),
                          Center(
                            child: Text(
                              company[index].label,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              itemCount: company.length,
            )
          ],
        ),
      ),
    );
  }
}

Widget Function(
  BuildContext context,
  int index,
  Animation<double> animation,
) animationItemBuilder(
  Widget Function(int index) child, {
  EdgeInsets padding = EdgeInsets.zero,
}) =>
    (
      BuildContext context,
      int index,
      Animation<double> animation,
    ) =>
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            child: Padding(
              padding: padding,
              child: child(index),
            ),
          ),
        );
