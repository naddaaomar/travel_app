import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';

class MainRow extends StatelessWidget {
  MainRow({super.key,required this.controller});

  AdvancedDrawerController controller;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Row(
          children: [
            Image.asset(
              'assets/images/logo_2.png',
              fit: BoxFit.cover,
              width: 120.w,
              height: 50.h,
              filterQuality: FilterQuality.high,
            ),
            Spacer(),
            IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: controller,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: value.visible?Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,

                          shape: BoxShape.circle
                      )
                      ,
                      child: Icon(Icons.clear,color: Colors.black,),):Icon(
                      Icons.menu ,
                      color: ColorApp.primaryColor,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();

    controller.showDrawer();
  }
}
