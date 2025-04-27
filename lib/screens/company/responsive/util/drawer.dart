import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';

var myDrawer = Drawer(
  backgroundColor: ColorApp.secondaryColor,
  elevation: 0,
  child: Column(
    children: [
      DrawerHeader(
        child: Icon(
          Icons.business_center_outlined,
          size: 64,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
        child: ListTile(
          leading: Icon(Icons.home,),
          title: Text(
            'D A S H B O A R D',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
        child: ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            'S E T T I N G S',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
        child: ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            'L O G O U T',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
    ],
  ),
);