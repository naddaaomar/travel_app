import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:p/main.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/settings/settings.dart';

class DrawerModel {
  String label;
  IconData icon;
  final Widget Function() widget;

  DrawerModel({required this.label, required this.icon,required this.widget});
}


List<DrawerModel> drawer = [
  DrawerModel(icon: Icons.home_outlined, label: 'home', widget: () => HomeViewBody()),
  DrawerModel(icon: Icons.event, label: 'upcoming Events', widget: () => Settings()),
  DrawerModel(icon: Icons.travel_explore, label: 'services', widget: () => Settings()),
  DrawerModel(icon: Icons.info_outline, label: 'about', widget: () => Settings()),
  DrawerModel(icon: Icons.chat, label: 'get In Touch', widget: () => Settings()),
  DrawerModel(icon: Icons.settings_outlined, label: 'settings', widget: () => Settings()),
];