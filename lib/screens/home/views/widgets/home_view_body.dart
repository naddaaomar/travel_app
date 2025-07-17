import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:p/screens/auth/core/cubit/auth_cubit.dart';
import '../../../tabs/profile/presentation/pages/profile_tab.dart';
import 'package:p/screens/auth/core/cubit/auth_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../tabs/profile/presentation/pages/profile_tab.dart';

enum AppBarState { transparent, color, hidden }

class HomeViewBody extends StatefulWidget {
  HomeViewBody({
    super.key,
  });
  static int currentIndex = 0;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> with TickerProviderStateMixin {
  final ValueNotifier<AppBarState> _appBarStateNotifier = ValueNotifier(AppBarState.transparent);
  final _secureStorage = const FlutterSecureStorage();
  final ValueNotifier<bool> isFieldFocused = ValueNotifier(false);
  final FocusNode focusNode = FocusNode();
  final _advancedDrawerController = AdvancedDrawerController();
  bool _isKeyboardVisible = false;
  bool _isCheckingAuth = true;

  List<Widget> get tabs => [
    HomeTab(),
    OffersScreen(),
    BlocProvider(
      create: (context) => AuthCubit()..checkAuthStatus(),
      child: PersonTab(
          appBarStateNotifier: _appBarStateNotifier),
    ),
    MapView(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAuth();
    _setupListeners();
  }

  Future<void> _initializeAuth() async {
    try {
      // Check if user is already authenticated
      final token = await _secureStorage.read(key: 'auth_token');
      if (token != null) {
        final isValid = await _verifyToken(token);
        if (!isValid) {
          await _secureStorage.delete(key: 'auth_token');
        }
      }
    } catch (e) {
      debugPrint('Auth initialization error: $e');
    } finally {
      if (mounted) {
        setState(() => _isCheckingAuth = false);
      }
    }
  }

  Future<bool> _verifyToken(String token) async {
    return true;
  }

  void _setupListeners() {
    _appBarStateNotifier.addListener(() {
      if (mounted) setState(() {});
    });

    focusNode.addListener(() {
      setState(() => isFieldFocused.value = focusNode.hasFocus);
    });

    KeyboardVisibilityController().onChange.listen((bool isVisible) {
      setState(() => _isKeyboardVisible = isVisible);
    });

    _advancedDrawerController.addListener(() {
      if (_advancedDrawerController.value.visible) {
        FocusScope.of(context).unfocus();
      } else {
        Future.delayed(const Duration(milliseconds: 200), () => setState(() {}));
      }
    });

    // Close keyboard on hot restart
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  // final ValueNotifier<bool> isFieldFocused = ValueNotifier(false);
  // FocusNode focusNode = FocusNode();
  //
  // final _advancedDrawerController = AdvancedDrawerController();
  // bool _isKeyboardVisible = false;

  @override
  void dispose() {
    _appBarStateNotifier.dispose();
    focusNode.dispose();
    super.dispose();
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    if (HomeViewBody.currentIndex != 2) {
      return AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        elevation: 0,
        leading: MainRow(controller: _advancedDrawerController),
        leadingWidth: double.infinity,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isLight
              ? Brightness.dark
              : Brightness.light,
        ),
      );
    }

    if (_appBarStateNotifier.value == AppBarState.hidden) {
      return null;
    }

    return AppBar(
      backgroundColor: _appBarStateNotifier.value == AppBarState.color
          ? isLight
          ? ColorApp.primaryColor
          : ColorApp.primaryColorDark
          : Colors.transparent,
      elevation: 0,
      leading: MainRow(controller: _advancedDrawerController),
      leadingWidth: double.infinity,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: _appBarStateNotifier.value == AppBarState.color
            ? Brightness.light
            : isLight
            ? Brightness.dark
            : Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingAuth) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return WillPopScope(
      onWillPop: () async {
        if (_advancedDrawerController.value.visible && HomeViewBody.currentIndex != 0) {
          _advancedDrawerController.hideDrawer();
          return false;
        }

        if (HomeViewBody.currentIndex != 0) {
          setState(() => HomeViewBody.currentIndex = 0);
          return false;
        }

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
            borderRadius: BorderRadius.all(Radius.circular(16)),),
          drawer: NewDrawer(controller: _advancedDrawerController),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: ValueKey(context.locale),
              extendBody: true,
              appBar: _buildAppBar(context),
              body: LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                  height: constraints.maxHeight,
                  child: Stack(
                    children: [
                      tabs[HomeViewBody.currentIndex],
                      ValueListenableBuilder<bool>(
                        valueListenable: isFieldFocused,
                        builder: (context, isFocused, child) => isFocused
                            ? Positioned.fill(
                             child: GestureDetector(
                               onTap: () => FocusScope.of(context).unfocus(),
                               child: Container(
                                 color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Chatbot()),
                ),
                backgroundColor: ColorApp.secondaryColor,
                elevation: 10,
                shape: CircleBorder(
                  side: BorderSide(
                    width: 3.w,
                    color: ColorApp.primaryColor,
                  ),
                ),
                child: Image.asset("assets/images/ai.png"),
              ),
              bottomNavigationBar: _isKeyboardVisible
                  ? const SizedBox.shrink()
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
                onTap: (index) => setState(() {
                  HomeViewBody.currentIndex = index;
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
