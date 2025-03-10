import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/settings/views/settings.dart';
import '../../../../../models/drawer_model.dart';

class NewDrawer extends StatefulWidget {
  NewDrawer({super.key, required this.controller});
  AdvancedDrawerController controller;

  @override
  State<NewDrawer> createState() => _NewDrawerState();
}

class _NewDrawerState extends State<NewDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 70,
          ),
          Image.asset(
            "assets/images/logo.png",
            width: 150,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Browse".toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white70),
          ),
          SizedBox(
            height: 15,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  radius: 30,
                  autofocus: true,
                  splashColor: Colors.black,
                  hoverColor: Colors.black,
                  hoverDuration: Duration(milliseconds: 1000),
                  onTap: () {
                    if (drawer[index].widget().runtimeType == HomeViewBody) {
                      widget.controller.hideDrawer();
                      Future.delayed(
                        Duration(milliseconds: 200),
                            () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomeViewBody()),
                                (route) => false, // This removes all previous routes
                          );
                        },
                      );
                      setState(() {
                        HomeViewBody.currentIndex = 0;
                      });
                    } else if (drawer[index].widget().runtimeType == Settings) {
                      if (ModalRoute.of(context)?.settings.name == "Settings") {
                        Future.delayed(
                          Duration(milliseconds: 200),
                              () => widget.controller.hideDrawer(),
                        );
                      } else {
                        widget.controller.hideDrawer();
                        Future.delayed(Duration(milliseconds: 200), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => drawer[index].widget(),
                              settings: RouteSettings(name: "Settings"),
                            ),
                          );
                        });
                      }
                    } else {
                      widget.controller.hideDrawer();
                      Future.delayed(Duration(milliseconds: 200), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => drawer[index].widget(),
                          ),
                        );
                      });
                    }
                  }
,
                  child: FadeInRight(
                    child: Row(
                      children: [
                        Icon(
                          drawer[index].icon,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          drawer[index].label.tr(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 30,
                  ),
              itemCount: drawer.length),
        ],
      ),
    );
  }
}
