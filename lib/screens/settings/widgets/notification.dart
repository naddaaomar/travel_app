import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/settings/bloc/notification_bloc/notification_bloc.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';

class NotificationToggle extends StatelessWidget {
  const NotificationToggle({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return FadeInUp(
      duration: Duration(milliseconds: 900),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: LinearGradient(
                colors: [Color(0xffFFB184), Color(0xff7F5E41)]),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FadeInUp(
          duration: Duration(milliseconds: 1000),
          child: Row(
            children: [
              Text(
                "Enable Notifications",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17.sp,
                  color: isLight ? Colors.black : Colors.white,
                ),
              ),
              Spacer(),
              BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  final isEnabled = state is NotificationLoaded
                      ? state.isEnabled
                      : true;
                  return Switch(
                    value: isEnabled,
                    onChanged: (value) {
                      context.read<NotificationBloc>().add(
                        ToggleNotification(value),
                      );
                    },
                    activeColor: ColorApp.primaryColor,
                    inactiveThumbColor: Colors.red,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}