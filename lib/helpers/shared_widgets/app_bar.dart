import 'package:flutter/material.dart';
import '../themes/colors.dart';

class TravelAppBar extends StatelessWidget {
  const TravelAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: Image.network('assets/logo.png'),

      actions: [
        IconButton(onPressed: (){

        },
          icon: const Icon(Icons.menu_outlined,
            color: Colors.white,),
          hoverColor: ColorApp.primaryColor,)
      ],
    );
  }
}