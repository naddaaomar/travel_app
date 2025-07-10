import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/view_all_events/presentation/pages/view_all_recommended_events_body.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';

class ViewAllEvents extends StatelessWidget {
  ViewAllEvents({super.key, required this.eventModel});

  List<EventsModel?>? eventModel;
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
            color: Colors.white,
            size: 30.w,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Events',
          style: TextStyle(
              color: ColorApp.thirdColor,
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
        child: FadeInUp(
            duration: const Duration(milliseconds: 1150),
            child: ViewAllEventsBody()),
      ),
    );
  }
}
