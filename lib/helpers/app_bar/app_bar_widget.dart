import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';

AppBar appBar({required String lable,required void Function()? onPressed  }){
  return AppBar(
    toolbarHeight: 75.h,
    backgroundColor: ColorApp.primaryColor,
    leading: Row(children: [
      IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 30.w,
        ),
      ),
      Expanded(
        child: FadeInUp(
          child: Text(
            lable,
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

    ],),
    leadingWidth: double.infinity,

  );
}