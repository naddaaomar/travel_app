import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/screens/event_details/views/widgets/view_all_recommended_events_body.dart';
import 'dart:ui' as ui;
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';

class ViewAllEvents extends StatelessWidget {
  const ViewAllEvents({super.key});

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
          'Events',
          style: TextStyle(
              fontFamily: "pop",
              color: ColorApp.thirdColor,
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
        child: ViewAllEventsBody(),
      ),
    );
  }
}
