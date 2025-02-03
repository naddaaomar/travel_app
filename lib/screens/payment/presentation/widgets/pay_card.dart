import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';

class PayCard extends StatelessWidget {
  String image;
   PayCard({super.key ,required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 10),
      child: FadeInUp(
        child: Card(
          elevation: 10,
          shadowColor: ColorApp.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
