import 'package:flutter/material.dart';
import 'views/widgets/profile_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: ProfileViewBody(),
      ),
    );
  }
}