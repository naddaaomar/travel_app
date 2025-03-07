import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';

class SettingsWidget extends StatelessWidget {
  SettingsWidget(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.isDown,
      required this.duration});
  String title;
  bool isDown;
  void Function()? onPressed;
  int duration;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: duration),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          IconButton(
              highlightColor: ColorApp.primaryColor.withOpacity(.4),
              onPressed: onPressed,
              icon: Icon(
                isDown ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
