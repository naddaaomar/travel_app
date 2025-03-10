import 'package:flutter/material.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/settings/views/settings.dart';

import 'rive_model.dart';

class Menu {
  final String title;
  final RiveModel rive;
  final Widget Function() widget;

  Menu({required this.title, required this.rive, required this.widget});
}

List<Menu> sidebarMenus = [
  Menu(
    title: "Home",
    widget: () => HomeViewBody(),
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "HOME",
        stateMachineName: "HOME_interactivity"),
  ),
  Menu(
    title: "Settings",
    widget: () => Settings(),
    rive: RiveModel(
        src: "assets/RiveAssets/icons.riv",
        artboard: "SETTINGS",
        stateMachineName: "SETTINGS_Interactivity"),
  ),
];
