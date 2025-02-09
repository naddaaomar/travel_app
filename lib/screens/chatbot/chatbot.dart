import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/screens/chatbot/respond.dart';
import 'package:p/screens/chatbot/sender.dart';
import 'package:p/screens/chatbot/suggest_item.dart';
import 'package:p/models/suggest_text.dart';

class Chatbot extends StatelessWidget {
  const Chatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20.r),
            bottomLeft: Radius.circular(20.r),
          )),
          backgroundColor: ColorApp.primaryColor,
          toolbarHeight: 80.h,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: ColorApp.secondaryColor,
                    size: 30.w,
                  )),
              Image.asset("assets/images/ai.png"),
            ],
          ),
          leadingWidth: 130.w,
          titleSpacing: 0,
          title: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Main Title",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.sp),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.lightGreen,
                      size: 13.w,
                    ),
                    Text(
                      "Online",
                      style: TextStyle(color: Colors.lightGreen, fontSize: 12.sp),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            Padding(
              padding:  EdgeInsets.only(right: 20.w),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_circle_outline_outlined,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        backgroundColor: ColorApp.secondaryColor,
        body: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w
              ),
              child: Column(
                children: [
                  Sender(),
                  Respond(),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      topLeft: Radius.circular(20.r))),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  DefaultTabController(
                    length: suggestLable.length,
                    child: TabBar(
                      tabs: suggestLable
                          .map(
                            (e) => SuggestItem(
                              lable: e.suggestion,
                            ),
                          )
                          .toList(),

                      dividerColor: Colors.transparent,
                      unselectedLabelColor: Colors.black,
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15.w),
                    child: TextFormField(
                      cursorColor: ColorApp.primaryColor,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.send_outlined,
                                color: Colors.blue.withOpacity(.7),
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.r)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          fillColor: Colors.grey.withOpacity(.3),
                          filled: true,
                          hintText: "Type your message here",
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(.5))),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
