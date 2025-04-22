import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/onboard/views/onboard_view.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      SystemChannels.textInput.invokeMethod('TextInput.hide'); // Force hide keyboard
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xffD8BCB0),
        Color(0xffD1A994),
        Color(0xffD2A288),
        Color(0xffD2A288),
        Color(0xffD1A994),
        Color(0xffD8BCB0),
      ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter)),
      child: AnimatedSplashScreen(
        disableNavigation: false,
        splash: Column(
          children: [
            Center(
              child: Image.asset(
                "assets/images/logo_2.png",
                width: 270,
                height: 200,
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        nextScreen: HomeViewBody(),
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
