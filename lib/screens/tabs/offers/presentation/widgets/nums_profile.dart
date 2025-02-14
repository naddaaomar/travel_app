import 'package:flutter/material.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/nums_column.dart';

class NumsProfile extends StatelessWidget {
  const NumsProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NumsColumn(
          txt: "Follower",
          value: "100K",
        ),
        Container(
          width: .5,
          height: 50,
          color: Colors.black,
        ),
        NumsColumn(
          txt: "Trips",
          value: "200",
        ),
        Container(
          width: .5,
          height: 50,
          color: Colors.black,
        ),
        NumsColumn(
          txt: "Reviews",
          value: "70K",
        ),
      ],
    );
  }
}
