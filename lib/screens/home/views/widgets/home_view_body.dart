import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';
import 'package:p/screens/home/views/widgets/main_row.dart';
import 'package:p/screens/tabs/home/home_tab.dart';
import 'package:p/screens/tabs/map/views/map_view.dart';
import 'package:p/screens/tabs/offers/presentation/pages/offers_screen.dart';
import 'dart:ui' as ui;
import '../../../settings/theme_bloc/theme_bloc.dart';
import '../../../tabs/profile/views/widgets/tab_bar.dart';

class HomeViewBody extends StatefulWidget {
  HomeViewBody({
    super.key,
  });
  static int currentIndex = 0;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with TickerProviderStateMixin {
  List<Widget> tabs = [
    HomeTab(),
    OffersScreen(),
    TabBarPage(),
    MapView(),
  ];

  @override
  void initState() {
    super.initState();

    _advancedDrawerController.addListener(() {
      if (!_advancedDrawerController.value.visible) {
        /// **Force UI rebuild when drawer closes**
        Future.delayed(
          Duration(milliseconds: 200),
          () => setState(() {}),
        );
      }
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return WillPopScope(
      onWillPop: () async {
        if (_advancedDrawerController.value.visible) {
          _advancedDrawerController.hideDrawer();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: AdvancedDrawer(
          backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFB06353),
                  Color(0xFFA77065),
                  Color(0xFFAB837B),
                  ColorApp.secondaryColor,
                ],
              ),
            ),
          ),
          openScale: .9,
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: true,
          openRatio: .5,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: NewDrawer(
            controller: _advancedDrawerController,
          ),
          child: Scaffold(
            key: ValueKey(context.locale),
            extendBody: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: MainRow(
                controller: _advancedDrawerController,
              ),
              leadingWidth: double.infinity,
            ),
            body: tabs[HomeViewBody.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              index: HomeViewBody.currentIndex,
              color:
                  isLight ? ColorApp.primaryColor : ColorApp.primaryColorDark,
              backgroundColor: Colors.transparent,
              animationDuration: const Duration(milliseconds: 400),
              items: [
                Icon(Icons.home, color: isLight ? Colors.black : Colors.white),
                Icon(Icons.local_offer_outlined,
                    color: isLight ? Colors.black : Colors.white),
                Icon(Icons.person,
                    color: isLight ? Colors.black : Colors.white),
                Image.asset('assets/images/map.png',
                    width: 35.w, color: isLight ? Colors.black : Colors.white)
              ],
              onTap: (index) {
                setState(() {
                  HomeViewBody.currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
