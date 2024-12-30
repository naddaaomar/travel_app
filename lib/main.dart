import 'package:flutter/material.dart';
import 'package:p/screens/onboard/views/onboard_view.dart';
import 'screens/home/views/home_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE0D7D7),
      ),

      home: OnBoardView(),
    );
  }
}
