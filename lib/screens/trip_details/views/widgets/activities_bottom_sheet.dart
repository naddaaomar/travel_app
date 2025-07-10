import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/trip_details/models/TravelDetailsModel.dart';

class ActivitiesBottomSheet extends StatelessWidget {
  ActivitiesBottomSheet({super.key, required this.itenraries});
  List<Itineraries> itenraries;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorApp.secondaryColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Activities",
              style: TextStyle(fontFamily: "vol", fontSize: 15),
            ),
            SizedBox(height: 15),
            ...itenraries
                .map((day) => Column(
                      children: [
                        Details(
                          day: "Day ${day.dayNumber ?? ''}",
                          txt1: day.activities?.isNotEmpty == true
                              ? day.activities![0]
                              : '',
                          txt2: (day.activities?.length ?? 0) > 1
                              ? day.activities![1]
                              : '',
                          txt3: (day.activities?.length ?? 0) > 2
                              ? day.activities![2]
                              : '',
                        ),
                        SizedBox(height: 20),
                      ],
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  Details(
      {super.key,
      required this.day,
      required this.txt1,
      required this.txt2,
      required this.txt3});
  String day;
  String txt1;
  String txt2;
  String txt3;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 2,
            decoration: BoxDecoration(
              color: ColorApp.primaryColor,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style:
                    TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              ActivityRow(txt: txt1),
              ActivityRow(txt: txt2),
              ActivityRow(txt: txt3),
            ],
          ),
        ],
      ),
    );
  }
}

class ActivityRow extends StatelessWidget {
  ActivityRow({super.key, required this.txt});
  String txt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: Colors.black54,
          size: 10,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          txt,
          style: TextStyle(
            fontFamily: "pop",
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
