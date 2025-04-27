import 'package:animate_do/animate_do.dart';
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
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 30.w,
          ),
        ),
        title: Center(
          child: Text('Recommended Events',
            style: TextStyle(
                color: ColorApp.thirdColor,
                fontWeight: FontWeight.bold,
                fontSize: 22
            ),),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:20 ,horizontal: 7),
        child: FadeInUp(
            duration: const Duration(milliseconds: 1150),
            child: ViewAllEventsBody()),
      ),
    );
  }
}