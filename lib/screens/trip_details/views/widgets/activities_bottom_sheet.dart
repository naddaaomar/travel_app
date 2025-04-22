import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';

class ActivitiesBottomSheet extends StatelessWidget {
  const ActivitiesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
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
            SizedBox(
              height: 15,
            ),
            Details(
              day: "Day 1",
              txt1: "Arrival at hotel",
              txt2: "Welcome dinner",
              txt3: "City orientation walk",
            ),
            SizedBox(height: 20),
            Details(
              day: "Day 2",
              txt1: "Morning sightseeing tour",
              txt2: "Lunch by the river",
              txt3: "Evening at the local market",
            ),
            SizedBox(height: 20),
            Details(
              day: "Day 3",
              txt1: "Visit historical museum",
              txt2: "Optional boat ride",
              txt3: "Farewell dinner",
            ),
            
          ],
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
   Details({super.key,required this.day,required this.txt1,required this.txt2, required this.txt3});
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
                 style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600),
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
        SizedBox(width: 10,),
        Text(txt,style:
          TextStyle(fontFamily: "pop",
          fontSize: 12,
          ),
        )
        
      ],
    );
  }
}
