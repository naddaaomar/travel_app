import 'package:flutter/material.dart';

class NumsColumn extends StatelessWidget {
  NumsColumn({super.key, required this.txt, required this.value});
  String value;
  String txt;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          txt,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
