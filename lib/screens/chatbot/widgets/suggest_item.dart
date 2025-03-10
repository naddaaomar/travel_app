import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/main.dart';

class SuggestItem extends StatelessWidget {
  String lable;
   SuggestItem({super.key,required this.lable});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.3),
          borderRadius: BorderRadius.circular(25.r),
          ),
      child: Text(
        lable ,
        style: TextStyle(
            fontSize: 15.sp),
      ),
    );
  }
}
