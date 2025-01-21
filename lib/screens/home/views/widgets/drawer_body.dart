import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/models/drawer_model.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .6,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30), topLeft: Radius.circular(30)),
          color: ColorApp.secondaryColor,
          gradient: LinearGradient(
            colors: [Color(0xffD0806F), ColorApp.secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.centerLeft,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
          ),
          Image.asset(
            "assets/images/logo.png",
            width: 150,
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              drawer[index].icon,
                              color: Colors.black,
                              size: 25,
                            ), ),
                        Text(
                          drawer[index].label,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      height: 10,
                      thickness: 2,
                      color: ColorApp.primaryColor,
                      endIndent: 20,
                      indent: 20,
                    ),
                itemCount:drawer.length ),
          )
        ],
      ),
    );
  }
}
