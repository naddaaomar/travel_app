import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';

class Respond extends StatelessWidget {
  const Respond({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: ColorApp.primaryColor,
                radius: 20.r,
                child: ClipOval(
                    child: Image.asset(
                      "assets/images/ai.png",
                      fit: BoxFit.cover,
                      width: 40.w,
                      height: 40.h,
                    )),
              ),
              BubbleSpecialTwo(
                text: "respond",
                color: ColorApp.primaryColor,
                tail: true,
                isSender: false,
                textStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
              ),

            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('MM/dd/yyyy, hh:mm a')
                    .format(DateTime.now())
                    .toString()
                    .substring(12),
                style: TextStyle(
                    color: Colors.black.withOpacity(.5),
                    fontSize: 11.sp),
              ),
              Icon(
                Icons.check,
                color: Colors.black.withOpacity(.5),
                size: 17.w,
              )
            ],
          )
        ],
      ),
    );
  }
}