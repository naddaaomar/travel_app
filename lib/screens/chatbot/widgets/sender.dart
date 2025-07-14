import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/main.dart';

class Sender extends StatelessWidget {
  const Sender({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BubbleSpecialTwo(
                text: "First message",
                color: Colors.grey.withOpacity(.3),
                tail: true,
                textStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
              ),
              CircleAvatar(
                radius: 20.r,
                child: ClipOval(
                    child: Image.asset(
                      "assets/images/profile.jpg",
                      fit: BoxFit.cover,
                      width: 40.w,
                      height: 40.h,
                    )),
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
                    color: Colors.black.withOpacity(.5), fontSize: 11.sp),
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