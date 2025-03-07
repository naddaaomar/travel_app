import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  double coverHeight = 280;
  double profileHeight = 144;
   ProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;


    return  Positioned(
      top: top,
      left:
      (MediaQuery.of(context).size.width - profileHeight) /
          2,
      child: CircleAvatar(
        radius: profileHeight / 2,
        backgroundImage:
        AssetImage("assets/images/terhaal.jpg"),
      ),
    );
  }
}
