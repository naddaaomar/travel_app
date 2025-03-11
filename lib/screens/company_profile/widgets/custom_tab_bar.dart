import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:p/helpers/themes/colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        animationDuration: Duration(milliseconds: 500),
        child: TabBar(
            dividerHeight: 0,
            onTap: (value) {},
            isScrollable: true,
            labelStyle: TextStyle(color: Colors.white),
            unselectedLabelColor: ColorApp.primaryColor,
            tabAlignment: TabAlignment.center,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 0),
            labelPadding: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            splashBorderRadius: BorderRadius.circular(7),
            unselectedLabelStyle: TextStyle(),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    colors: const [ColorApp.primaryColor, Color(0xffE2A093)])),
            tabs: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: GradientBoxBorder(
                          gradient: LinearGradient(colors: const [
                        ColorApp.primaryColor,
                        Color(0xffE2A093)
                      ]))),
                  child: Text("All")),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: GradientBoxBorder(
                          gradient: LinearGradient(colors: const [
                        ColorApp.primaryColor,
                        Color(0xffE2A093)
                      ]))),
                  child: Text("Beach")),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: GradientBoxBorder(
                          gradient: LinearGradient(colors: const [
                        ColorApp.primaryColor,
                        Color(0xffE2A093)
                      ]))),
                  child: Text("Religious")),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: GradientBoxBorder(
                          gradient: LinearGradient(colors: const [
                        ColorApp.primaryColor,
                        Color(0xffE2A093)
                      ]))),
                  child: Text("Safari")),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: GradientBoxBorder(
                          gradient: LinearGradient(colors: const [
                        ColorApp.primaryColor,
                        Color(0xffE2A093)
                      ]))),
                  child: Text("Urban")),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: GradientBoxBorder(
                          gradient: LinearGradient(colors: const [
                        ColorApp.primaryColor,
                        Color(0xffE2A093)
                      ]))),
                  child: Text("Cultural")),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: GradientBoxBorder(
                          gradient: LinearGradient(colors: const [
                        ColorApp.primaryColor,
                        Color(0xffE2A093)
                      ]))),
                  child: Text("Nile Cruises")),
            ]));
  }
}
