import 'package:flutter/material.dart';
import '../themes/colors.dart';

class BottomNavigatorBar extends StatelessWidget {
  const BottomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      fixedColor:  ColorApp.primaryColor,
      currentIndex: 0,
      unselectedItemColor: Colors.black,

      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home) ,label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined) ,label: 'Hot Deals'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person) ,label: 'Get In Touch'),
      ],
    );
  }
}