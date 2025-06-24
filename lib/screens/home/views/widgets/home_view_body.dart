import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
<<<<<<<<< Temporary merge branch 1
=========
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
>>>>>>>>> Temporary merge branch 2
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/screens/home/views/widgets/drawer/menu.dart';
import 'package:p/screens/home/views/widgets/drawer/menu_btn.dart';
import 'package:p/screens/home/views/widgets/drawer/side_bar.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/home/home_tab.dart';
import 'package:p/screens/tabs/map/views/map_view.dart';
import 'package:p/screens/tabs/offers/presentation/pages/offers_screen.dart';
import 'package:rive/rive.dart';
import 'package:flutter/widgets.dart' as flutter_widgets;
import 'package:rive/rive.dart' as rive;

import '../../../chatbot/views/chatbot.dart';
import '../../../tabs/profile/views/widgets/tab_bar.dart';


class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  static int currentIndex = 0;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Widget> tabs = [
    HomeTab(),
    OffersScreen(),
    TabBarPage(),
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
<<<<<<<<< Temporary merge branch 1
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  int _page = 0;
=========


    focusNode.addListener(() {
     setState(() {
       isFieldFocused.value = focusNode.hasFocus;
     });
    });
    // Listen to keyboard visibility changes
    KeyboardVisibilityController().onChange.listen((bool isVisible) {
      setState(() {
        _isKeyboardVisible = isVisible;
      });
    });
    _advancedDrawerController.addListener(() {
      if (_advancedDrawerController.value.visible) {
        FocusScope.of(context).unfocus(); // Close the keyboard when the drawer opens
      } else {
        Future.delayed(
          Duration(milliseconds: 200),
              () => setState(() {}),
        );
      }
    });

    // Close keyboard on hot restart
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  final ValueNotifier<bool> isFieldFocused = ValueNotifier(false);
  FocusNode focusNode = FocusNode();

  final _advancedDrawerController = AdvancedDrawerController();
  bool _isKeyboardVisible = false;
>>>>>>>>> Temporary merge branch 2

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;

<<<<<<<<< Temporary merge branch 1
    return SafeArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            key: ValueKey(context.locale),
            extendBody: true,
            body:  Stack(children: [
                    AnimatedPositioned(
                      width: 250.w,
                      height: MediaQuery.of(context).size.height,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                      right: isSideBarOpen ? 0 : -288.w,
                      top: 0,
                      child:  SideBar(onTap: () { },),
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
=========
    return WillPopScope(
      onWillPop: () async {
        if (_advancedDrawerController.value.visible &&
            HomeViewBody.currentIndex != 0) {
          _advancedDrawerController.hideDrawer();
          return false;
        }

        if (HomeViewBody.currentIndex != 0) {
          setState(() {
            HomeViewBody.currentIndex = 0; // Switch to Home tab
          });
          return false; // Prevent app from closing
        }

        if (_advancedDrawerController.value.visible) {
          _advancedDrawerController.hideDrawer();
          return false;
        }

        return true; // Exit the app
      },
      child: SafeArea(
        child: AdvancedDrawer(
          backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                tileMode: TileMode.repeated,
                colors: ColorApp.drawerColors,
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
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: ValueKey(context.locale),
              extendBody: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: MainRow(
                  controller: _advancedDrawerController,
                ),
                leadingWidth: double.infinity,
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: constraints.maxHeight, // Ensure it takes full height
                    child: Stack(
                      children: [
                        tabs[HomeViewBody.currentIndex],
                        ValueListenableBuilder<bool>(
                          valueListenable: isFieldFocused,
                          builder: (context, isFocused, child) {
                            return isFocused
                                ? Positioned.fill(
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus(); // Close keyboard when tapping the background
                                },
                                child: Container(
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            )
                                : SizedBox.shrink();
                          },
                        ),

                      ],
                    ),
                  );
                },
              ),



                bottomNavigationBar: _isKeyboardVisible
                  ? SizedBox.shrink() // Hide navigation bar when keyboard is visible
                  : CurvedNavigationBar(
                index: HomeViewBody.currentIndex,
>>>>>>>>> Temporary merge branch 2
                color: isLight ? ColorApp.primaryColor : ColorApp.primaryColorDark,
                backgroundColor: Colors.transparent,
                animationDuration: const Duration(milliseconds: 400),
                items: [
<<<<<<<<< Temporary merge branch 1
                  Icon(
                    Icons.home,
                    color: isLight ? Colors.black : Colors.white,
                  ),
                  Icon(Icons.local_offer_outlined,
                      color: isLight ? Colors.black : Colors.white),
                  Icon(Icons.person, color: isLight ? Colors.black : Colors.white),
                  flutter_widgets.Image.asset('assets/images/map.png',
                      width: 35.w, color: isLight ? Colors.black : Colors.white)
=========
                  Icon(Icons.home, color: isLight ? Colors.black : Colors.white),
                  Icon(Icons.local_offer_outlined, color: isLight ? Colors.black : Colors.white),
                  Icon(Icons.person, color: isLight ? Colors.black : Colors.white),
                  Image.asset(
                    'assets/images/map.png',
                    width: 35.w,
                    color: isLight ? Colors.black : Colors.white,
                  ),
>>>>>>>>> Temporary merge branch 2
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
          );
        }
      ),
    );
  }

}
