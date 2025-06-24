import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:p/screens/company_profile/models/CompanyDetails.dart';

class TabOne extends StatelessWidget {
  TabOne({super.key, required this.data});
  CompanyDetailsModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
        ),
        InfoWidget(title: "Description", txt: data.description ?? ""),
        SizedBox(
          height: 15,
        ),
        InfoWidget(title: "Email", txt: data.email ?? ""),
        SizedBox(
          height: 15,
        ),
        InfoWidget(title: "Address", txt: data.address ?? ""),
        SizedBox(
          height: 15,
        ),
        InfoWidget(title: "Phone", txt: data.phoneNumber ?? ""),
        SizedBox(
          height: 15,
        ),
        InfoWidget(title: "Website", txt: data.website ?? ""),
        SizedBox(
          height: 15,
        ),
        InfoWidget(title: "Established Date", txt: data.establishedDate ?? ""),

      ],
    );
  }
}

class InfoWidget extends StatelessWidget {
  InfoWidget({super.key, required this.title, required this.txt});
  String title;
  String txt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInUp(
            duration: Duration(milliseconds: 2300),
            child: Text(
              title,
              style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600),
            )),
        SizedBox(
          height: 5,
        ),
        FadeInUp(
          duration: Duration(milliseconds: 2500),
          child: Text(
            txt,
            style: TextStyle(
              fontFamily: "pop",
            ),
          ),
        ),
      ],
    );
  }
}
