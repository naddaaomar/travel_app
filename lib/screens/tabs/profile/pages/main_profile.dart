import 'package:flutter/material.dart';
import '../views/widgets/profile_body.dart';
import '../views/widgets/profile_topbar.dart';
import '../views/widgets/tabs/first.dart';

class MainProfile extends StatelessWidget {
  const MainProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          TopBar(),
          ProfileBody(),
        ],
      ),
    );
  }
}
