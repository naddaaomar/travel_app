import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:p/helpers/themes/colors.dart';


class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        color: ColorApp.primaryColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 4,top: 24),
            child: Text('Welcome',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "vol",
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFF3F3F3)
              ),),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
