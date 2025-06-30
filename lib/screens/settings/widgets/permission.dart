import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/settings/bloc/permission_bloc/permissions_bloc.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';

class PermissionsToggle extends StatelessWidget {
  final String permissionType;
  final IconData icon;

  const PermissionsToggle({
    super.key,
    required this.permissionType,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return BlocBuilder<PermissionsBloc, PermissionsState>(
      builder: (context, state) {
        final isEnabled = state is PermissionsLoaded
            ? state.permissions[permissionType] ?? false
            : false;

        return Container(
          width: 80.w,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  size: 28.sp,
                  color: isLight ? Colors.black : Colors.white),
              SizedBox(height: 6.h),
              Switch(
                value: isEnabled,
                onChanged: (value) {
                  context.read<PermissionsBloc>().add(
                    RequestPermission(permissionType),
                  );
                },
                activeColor: ColorApp.primaryColor,
                inactiveThumbColor: Colors.red,
              ),
            ],
          ),
        );
      },
    );
  }
}



class PermissionsContainer extends StatelessWidget {
  const PermissionsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: const [Color(0xffFFB184), Color(0xff7F5E41)],
          ),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          PermissionsToggle(
            permissionType: 'location',
            icon: Icons.location_on_outlined,
          ),
          PermissionsToggle(
            permissionType: 'camera',
            icon: Icons.camera_alt,
          ),
          PermissionsToggle(
            permissionType: 'microphone',
            icon: Icons.mic,
          ),
        ],
      ),
    );
  }
}