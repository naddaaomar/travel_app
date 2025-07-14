import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/chatbot/views/chatbot.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';
import 'package:p/screens/home/views/widgets/main_row.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/home/presentation/pages/home_tab.dart';
import 'package:p/screens/tabs/map/views/map_view.dart';
import 'package:p/screens/tabs/offers/presentation/pages/offers_screen.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_cubit.dart';
import 'package:p/screens/tabs/profile/views/pages/profile_tab.dart';

enum AppBarState { transparent, color, hidden }

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
  final ValueNotifier<AppBarState> _appBarStateNotifier =
  ValueNotifier(AppBarState.transparent);

  List<Widget> get tabs => [
    HomeTab(),
    OffersScreen(),
    BlocProvider(
      create: (context) => AuthCubit(),
      child: PersonTab(
          appBarStateNotifier: _appBarStateNotifier),
    ),
    MapView(),
  ];

  @override
  void initState() {
    super.initState();
    _appBarStateNotifier.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

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
        FocusScope.of(context)
            .unfocus(); // Close the keyboard when the drawer opens
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

  @override
  void dispose() {
    _appBarStateNotifier.dispose();
    super.dispose();
  }

  PreferredSizeWidget? _buildAppBar() {
    if (HomeViewBody.currentIndex != 2) {
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: MainRow(
          controller: _advancedDrawerController,
        ),
        leadingWidth: double.infinity,
      );
    }

    if (_appBarStateNotifier.value == AppBarState.hidden) {
      return null;
    }

    return AppBar(
      backgroundColor:
      _appBarStateNotifier.value == AppBarState.color ? Color(0xFFDF6951) : Colors.transparent,
      elevation: 0,
      leading: MainRow(
        controller: _advancedDrawerController,
      ),
      leadingWidth: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

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
          return false;
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

              appBar: _buildAppBar(),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height:
                    constraints.maxHeight, // Ensure it takes full height
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
                                  FocusScope.of(context)
                                      .unfocus(); // Close keyboard when tapping the background
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
              floatingActionButton: FloatingActionButton(
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
                child: Image.asset("assets/images/ai.png"),
              ),
              bottomNavigationBar: _isKeyboardVisible
                  ? SizedBox
                  .shrink() // Hide navigation bar when keyboard is visible
                  : CurvedNavigationBar(
                index: HomeViewBody.currentIndex,
                color: isLight
                    ? ColorApp.primaryColor
                    : ColorApp.primaryColorDark,
                backgroundColor: Colors.transparent,
                animationDuration: const Duration(milliseconds: 400),
                items: [
                  Icon(Icons.home,
                      color: isLight ? Colors.black : Colors.white),
                  Icon(Icons.local_offer_outlined,
                      color: isLight ? Colors.black : Colors.white),
                  Icon(Icons.person,
                      color: isLight ? Colors.black : Colors.white),
                  Image.asset(
                    'assets/images/map.png',
                    width: 35.w,
                    color: isLight ? Colors.black : Colors.white,
                  ),
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
      ),
    );
  }
}