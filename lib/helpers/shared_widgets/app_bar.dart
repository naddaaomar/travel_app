import 'package:flutter/material.dart';
import '../../screens/home/views/home_view.dart';
import '../themes/colors.dart';

class TravelAppBar extends StatelessWidget {
  const TravelAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.black,
      leading: Image.asset(
        'assets/logo.png',
        filterQuality: FilterQuality.high, ),

      actions: [
        IconButton(
          onPressed: (){
        },

          icon: const Icon(Icons.menu_outlined,
            color: Colors.white,),
          hoverColor: ColorApp.primaryColor,)
      ],
    );
  }
}