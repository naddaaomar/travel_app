import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:p/main.dart';
import 'package:p/screens/all_discount_travels/presentation/pages/all_discounts.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/settings/views/settings.dart';

import '../screens/all_companies/presentation/pages/all_companies.dart';
import '../screens/all_travels/presentation/pages/all_travels.dart';

class DrawerModel {
  String label;
  IconData icon;
  final Widget Function() widget;

  DrawerModel({required this.label, required this.icon, required this.widget});
}

List<DrawerModel> drawer = [
  DrawerModel(
      icon: Icons.home_outlined, label: 'home', widget: () => HomeViewBody()),
DrawerModel(
icon: Icons.cases_outlined, label: 'All Travels', widget: () => AllTravels()),
  DrawerModel(
      icon: Icons.cases_outlined, label: 'All Discounts', widget: () => AllDiscounts()),
DrawerModel(
icon: Icons.domain, label: 'All Companies', widget: () => AllCompanies()),
  DrawerModel(
      icon: Icons.settings_outlined,
      label: 'settings',
      widget: () => Settings()),


];
