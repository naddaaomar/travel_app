import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class TabOne extends StatelessWidget {
  const TabOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        FadeInUp(
          duration: Duration(milliseconds: 2300),
          child: Text(
              "Explore Egypt with Terhal! 🇪🇬✨\n\nDiscover the beauty of Egypt with expertly planned trips to iconic destinations like the Pyramids, the Nile, and the Red Sea. Whether you seek adventure, relaxation, or cultural experiences, we offer customized itineraries and professional guides for a seamless journey. Let us take you beyond the ordinary and unveil the wonders of Egypt!"),
        ),
      ],
    );
  }
}
