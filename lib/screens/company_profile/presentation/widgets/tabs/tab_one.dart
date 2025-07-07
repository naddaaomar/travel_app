import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/company_profile/data/models/CompanyDetailsModel.dart';
import 'package:shimmer/shimmer.dart';

class TabOne extends StatelessWidget {
  TabOne({super.key, required this.data, required this.isLoading});
  CompanyDetailsModel? data;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(6, (index) {
                  final widths = [200.0, 250.0, 180.0, 220.0, 160.0, 230.0];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Shimmer.fromColors(
                      baseColor: const Color(0xffD8D1CA),
                      highlightColor: const Color(0xffCBC0B6),
                      child: Container(
                        width: widths[index],
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoWidget(
                      title: "Description",
                      txt: data?.description ?? "",
                      iconData: Ionicons.information_circle_outline,
                    ),
                    SizedBox(height: 15),
                    InfoWidget(
                      title: "Email",
                      txt: data?.email ?? "",
                      iconData: Ionicons.mail_outline,
                    ),
                    SizedBox(height: 15),
                    InfoWidget(
                      title: "Address",
                      txt: data?.address ?? "",
                      iconData: Ionicons.location_outline,
                    ),
                    SizedBox(height: 15),
                    InfoWidget(
                      title: "Phone",
                      txt: data?.phoneNumber ?? "",
                      iconData: Ionicons.call_outline,
                    ),
                    SizedBox(height: 15),
                    InfoWidget(
                      title: "Website",
                      txt: data?.website ?? "",
                      iconData: Ionicons.globe_outline,
                    ),
                    SizedBox(height: 15),
                    InfoWidget(
                      title: "Established Date",
                      txt: data?.establishedDate ?? "",
                      iconData: Ionicons.calendar_outline,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (_) => WorkingHoursSheet(
                              workingHours: data?.workingHours ?? []),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: GradientBoxBorder(
                                gradient: LinearGradient(colors: [
                                  ColorApp.thirdColor.withOpacity(.5),
                                  Colors.brown
                                ]),
                                width: 2),
                            color: Color(0xffE4D3CB).withOpacity(1)),
                        child: Row(
                          children: [
                            Icon(Icons.access_time,
                                size: 20, color: ColorApp.thirdColor),
                            SizedBox(width: 8),
                            Text(
                              "View Working Hours",
                              style: TextStyle(
                                  fontFamily: "pop",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorApp.thirdColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorApp.thirdColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  InfoWidget(
      {super.key,
      required this.title,
      required this.txt,
      required this.iconData});
  String title;
  String txt;
  IconData iconData;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 2300),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: GradientBoxBorder(
                gradient: LinearGradient(colors: [
                  ColorApp.thirdColor.withOpacity(.5),
                  Colors.brown
                ]),
                width: 2),
            color: Color(0xffE4D3CB).withOpacity(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                  color: ColorApp.thirdColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style:
                      TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              txt,
              style: TextStyle(
                fontFamily: "pop",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkingHoursSheet extends StatelessWidget {
  List<WorkingHours> workingHours;

  WorkingHoursSheet({super.key, required this.workingHours});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorApp.secondaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      padding: EdgeInsets.all(20),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Text(
            "Working Hours",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "pop",
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: workingHours.length,
              itemBuilder: (context, index) {
                final item = workingHours[index];
                return ListTile(
                  leading: Icon(Icons.calendar_today_outlined, size: 20),
                  title: Text(
                    item.dayOfWeek ?? "",
                    style: TextStyle(
                        fontFamily: "pop", fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    item.workingTime ?? "",
                    style:
                        TextStyle(fontFamily: "pop", color: Colors.grey[700]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
