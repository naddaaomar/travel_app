import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    Future.delayed(Duration.zero, () {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
      ),
      child: AnimatedSplashScreen(
        disableNavigation: false,
        splash: Lottie.asset(
          "assets/lottie/splash.json",
          controller: _controller,
          onLoaded: (composition) {
            _controller.duration = composition.duration;
          },
        ),
        backgroundColor: Colors.transparent,
        nextScreen: HomeViewBody(),
        splashIconSize: 250,
        duration: 900,
        pageTransitionType: PageTransitionType.bottomToTop,
      ),
    );
  }
}
