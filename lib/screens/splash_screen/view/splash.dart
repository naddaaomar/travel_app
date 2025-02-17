import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/onboard/views/onboard_view.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSplashScreen(
        disableNavigation: false,
        splash: Column(
          children: [Center(
            child: Image.asset("assets/images/logo_2.png",
            width: 270,
           height: 200, ),
          )],
        ),
        backgroundColor: ColorApp.secondaryColor,
        nextScreen: OnBoardView(),
        splashIconSize: 250,
        duration: 1000,
        curve: Curves.bounceOut,
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        animationDuration: Duration(milliseconds: 1300),
      ),
    );
  }
}
