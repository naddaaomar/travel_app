import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/models/drawer_model.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;

    return Container(
      width: MediaQuery.of(context).size.width * .6,
      decoration:  BoxDecoration(
          borderRadius:BorderRadius.all(Radius.circular(30)),

          gradient: LinearGradient(
            colors: isLight?[Color(0xffD0806F), ColorApp.secondaryColor]:[Color(0xff734339), ColorApp.secondaryColorDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => drawer[index].widget(),
                            ));

                    },
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            drawer[index].icon,
                            color:isLight?Colors.black:Colors.white,
                            size: 25,
                          ),
                        ),
                        Text(
                          drawer[index].label.tr(),
                          style:  TextStyle(
                              fontSize: 15,
                              color:isLight?Colors.black:Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: drawer.length),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/linkedin.png",
              color: isLight?ColorApp.primaryColor:Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset("assets/images/messenger.png",
                color: isLight?ColorApp.primaryColor:Colors.white,),
              const SizedBox(
                width: 10,
              ),
              Image.asset("assets/images/x.png",
                color: isLight?ColorApp.primaryColor:Colors.white,),
              const SizedBox(
                width: 10,
              ),
              Image.asset("assets/images/vector.png",
                color: isLight?ColorApp.primaryColor:Colors.white,),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
