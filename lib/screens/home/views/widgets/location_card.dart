import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
       Card(
        color: const Color(0xFFD7D1D1),
        elevation: 10,
        shadowColor: ColorApp.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Text(
                    "Where to?",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                      color: const Color(0xFF787474),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                    color: ColorApp.primaryColor,
                    borderRadius: BorderRadius.circular(10)),

                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {},

                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}