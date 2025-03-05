import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return
       Card(
        color: isLight? Color(0xFFD7D1D1):Color(0xFF8C8282),
        elevation: 3,
        shadowColor: isLight?ColorApp.primaryColor:ColorApp.primaryColorDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.only(left: 10.w),
              child: Column(
                children: [
                  Text(
                    "where to?".tr(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                      color: isLight? Color(0xFF787474):Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                    color: isLight?ColorApp.primaryColor:ColorApp.primaryColorDark,
                    borderRadius: BorderRadius.circular(10.r)),

                child: InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: () {},

                  child:  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}