import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:p/di.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/bloc_observer/bloc_observer.dart';
import 'screens/home/views/home_view.dart';
import 'screens/onboard/views/onboard_view.dart';

void main() {
  ApiManager.init();
  Bloc.observer = MyBlocObserver();
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE0D7D7),
      ),
      home: OnBoardView(),
    );
  }
}
