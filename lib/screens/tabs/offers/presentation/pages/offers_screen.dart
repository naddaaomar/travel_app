import 'package:auto_animated/auto_animated.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/offers/presentation/pages/company_offers.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/companies.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/company_home_card.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/dont_miss.dart';

class OffersScreen extends StatelessWidget {
  OffersScreen({super.key});

  var company = CompanyModel.Companies();

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "don't miss".tr(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                  color: isLight ? Colors.black : Colors.white),
            ),

            DontMiss(),
            SizedBox(
              height: 24.h,
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
            SizedBox(
              height: 15,
            ),
            LiveGrid(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              visibleFraction: 0.001,
              showItemInterval: Duration(milliseconds: 80),
              showItemDuration: Duration(milliseconds: 150),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .86,
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 0),
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
                  child: CompanyHomeCard(
                      img: company[index].imagePath,
                      label: company[index].label))),
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
