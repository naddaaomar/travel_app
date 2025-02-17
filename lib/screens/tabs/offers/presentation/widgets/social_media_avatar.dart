import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';

class SocialMediaAvatar extends StatelessWidget {
  SocialMediaAvatar({super.key, required this.icon});
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 23,
      child: Material(
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Center(
            child: Icon(
              color: ColorApp.primaryColor,
              icon,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
