import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/screens/home/views/widgets/drawer/menu.dart';
import 'package:p/screens/home/views/widgets/drawer/rive_utils.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';

import '../../../../../helpers/themes/colors.dart';
import 'side_menu.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Menu selectedSideMenu = sidebarMenus.first;
  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return SafeArea(
      child: Container(
        width: 288.w,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLight
                ? [Color(0xffD0806F), ColorApp.secondaryColor]
                : [Color(0xff734339), ColorApp.secondaryColorDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(30.r),
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 24.w, top: 24.w),
                  child: Image.asset(
                    "assets/images/logo_2.png",
                    width: 180,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 24.w, top: 32.h, bottom: 16.h),
                  child: Text(
                    "Browse".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white70),
                  ),
                ),
                ...sidebarMenus.map((menu) => SideMenu(
                      menu: menu,
                      selectedMenu: selectedSideMenu,
                      press: () {
                        RiveUtils.chnageSMIBoolState(menu.rive.status!);
                        setState(() {
                          selectedSideMenu = menu;
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => menu.widget(),
                            ));
                      },
                      riveOnInit: (artboard) {
                        menu.rive.status = RiveUtils.getRiveInput(artboard,
                            stateMachineName: menu.rive.stateMachineName);
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
