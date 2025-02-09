import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/screens/chatbot/chatbot.dart';
import 'package:p/screens/home/views/widgets/drawer/menu.dart';
import 'package:p/screens/home/views/widgets/drawer/menu_btn.dart';
import 'package:p/screens/home/views/widgets/drawer/side_bar.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/home/home_tab.dart';
import 'package:p/screens/tabs/map/views/map_view.dart';
import 'package:p/screens/tabs/offers/presentation/pages/offers_screen.dart';
import 'package:p/screens/tabs/tab3/views/tab3_view.dart';
import 'package:rive/rive.dart';
import 'package:flutter/widgets.dart' as flutter_widgets;
import 'package:rive/rive.dart' as rive;


class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Widget> tabs = [
    HomeTab(),
    OffersScreen(),
    Tab3(),
    MapView(),
  ];
  bool isSideBarOpen = false;

  Menu selectedSideMenu = sidebarMenus.first;

  late SMIBool isMenuOpenInput;

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body:  Stack(children: [
                AnimatedPositioned(
                  width: 250.w,
                  height: MediaQuery.of(context).size.height,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  right: isSideBarOpen ? 0 : -288.w,
                  top: 0,
                  child: const SideBar(),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(
                        1 * animation.value - 100 * (animation.value) * pi / 180),
                  child: Transform.translate(
                    offset: Offset(-animation.value * 215, 0),
                    child: Transform.scale(
                      scale: scalAnimation.value,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24.r),
                        ),
                        child: tabs[_tabController.index],
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  left: isSideBarOpen ? 350.w :350.w,

                  top: isSideBarOpen ? 20.h :0,
                  child: MenuBtn(
                    press: () {
                      isMenuOpenInput.value = !isMenuOpenInput.value;

                      if (_animationController.value == 0) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }

                      setState(
                        () {
                          isSideBarOpen = !isSideBarOpen;
                        },
                      );
                    },
                    riveOnInit: (artboard) {
                      final controller = StateMachineController.fromArtboard(
                          artboard, "State Machine");

                      artboard.addController(controller!);

                      isMenuOpenInput =
                          controller.findInput<bool>("isOpen") as SMIBool;
                      isMenuOpenInput.value = true;
                    },
                  ),
                ),
              ])
        ,
        bottomNavigationBar: Transform.translate(
          offset: Offset(0, 100 * animation.value),
          child: CurvedNavigationBar(
            index: _tabController.index,
            color: isLight ? ColorApp.primaryColor : ColorApp.primaryColorDark,
            backgroundColor: Colors.transparent,
            animationDuration: const Duration(milliseconds: 400),
            items: [
              Icon(
                Icons.home,
                color: isLight ? Colors.black : Colors.white,
              ),
              Icon(Icons.local_offer_outlined,
                  color: isLight ? Colors.black : Colors.white),
              Icon(Icons.person, color: isLight ? Colors.black : Colors.white),
              flutter_widgets.Image.asset('assets/images/map.png',
                  width: 35.w, color: isLight ? Colors.black : Colors.white)
            ],
            onTap: (index) {
              setState(() {
                _page = index;
                _tabController.index = index;
              });
            },
            letIndexChange: (index) => true,
          ),
        ),
        floatingActionButton: Transform.translate(
          offset: Offset(0, 200 * animation.value),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Chatbot(),
                  ));
            },
            backgroundColor: ColorApp.secondaryColor,
            elevation: 10,
            shape: CircleBorder(
                side: BorderSide(width: 3.w, color: ColorApp.primaryColor)),
            child: flutter_widgets.Image.asset("assets/images/ai.png"),
          ),
        ),
      ),
    );
  }
}
