import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'view_all_nearby_trips_body.dart';

class ViewAllTrips extends StatelessWidget {
  const ViewAllTrips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ColorApp.thirdColor,
            size: 25.w,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Nearby Trips',
          style: TextStyle(
              color: ColorApp.thirdColor,
              fontWeight: FontWeight.w600,
              fontFamily: "pop",
              fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
        child: ViewAllNearbyBody(),
      ),
    );
  }
}