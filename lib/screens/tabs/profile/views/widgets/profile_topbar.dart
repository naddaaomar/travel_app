import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        color: ColorApp.primaryColor,
      ),
    );
  }
}
