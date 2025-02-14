import 'package:flutter/material.dart';

class CoverCompany extends StatelessWidget {
   CoverCompany({super.key});
  double coverHeight = 280;
   double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return    Container(
      margin: EdgeInsets.only(bottom:profileHeight/2 ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)),
        child: Image.asset(
          "assets/images/company_pic.jpeg",
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
