import 'package:flutter/material.dart';
import 'views/widgets/profile_view_body.dart';

class ProfView extends StatelessWidget {
  const ProfView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: ProfileViewBody(),
      ),
    );
  }
}