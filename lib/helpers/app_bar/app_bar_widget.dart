import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';

AppBar appBar(
    {required String lable,
    required void Function()? onPressed,
     AdvancedDrawerController? controller,
     void Function()? menuOnPressed}) {
  return AppBar(
    toolbarHeight: 75.h,
    backgroundColor: ColorApp.primaryColor,
    leading: Row(
      children: [
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

        IconButton(
          onPressed: menuOnPressed,
          icon: ValueListenableBuilder<AdvancedDrawerValue>(
            valueListenable: controller!,
            builder: (_, value, __) {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: value.visible
                    ? Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                      )
                    : Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 30,
                        key: ValueKey<bool>(value.visible),
                      ),
              );
            },
          ),
        )
      ],
    ),
    leadingWidth: double.infinity,
  );
}

class AppBarWidget extends StatelessWidget {
  AppBarWidget(
      {super.key,
      required this.onPressed,
      required this.lable,
      required this.onPressedMenu});
  String lable;
  void Function()? onPressed;
  void Function()? onPressedMenu;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      child: Row(
        children: [
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
          IconButton(
              onPressed: onPressedMenu,
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
    );
  }
}
