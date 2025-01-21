import 'package:flutter/material.dart';

class DrawerModel {
  String label;
  IconData icon;

  DrawerModel({required this.label, required this.icon});
}

List<DrawerModel> drawer = [
  DrawerModel(icon: Icons.home_outlined, label: 'Home'),
  DrawerModel(icon: Icons.event, label: 'Upcomming Events'),
  DrawerModel(icon: Icons.travel_explore, label: 'Services'),
  DrawerModel(icon: Icons.info_outline, label: 'About'),
  DrawerModel(icon: Icons.chat, label: 'Get In Touch'),
];
