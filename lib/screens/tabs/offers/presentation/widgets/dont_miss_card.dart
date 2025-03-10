import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/dont_miss_model.dart';

class DontMissCard extends StatelessWidget {
  DontMissModel dontMissModel;
  DontMissCard({super.key, required this.dontMissModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            dontMissModel.image,
            height: 170,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 4),
                        Text(
                          dontMissModel.place,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          dontMissModel.offer,
                          style: TextStyle(
                            color: ColorApp.primaryColor,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "🔥",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 23),
                  child: Text(
                    dontMissModel.comName,
                    style: TextStyle(color: Colors.black.withOpacity(.6)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
