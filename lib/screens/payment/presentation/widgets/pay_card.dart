import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';

class PayCard extends StatelessWidget {
  String image;
   PayCard({super.key ,required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 70.w,vertical: 10.h),
      child: FadeInUp(
        child: Container(
          // elevation: 10,
          // shadowColor: ColorApp.primaryColor,
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.r,
                spreadRadius: 10.r
              ),
            ],),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 150.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
