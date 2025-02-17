import 'package:flutter/material.dart';
import '../../../../../helpers/themes/colors.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with SingleTickerProviderStateMixin {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20 ,right: 20 ,top: 96),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        ),
        child: SizedBox(
            height: 20,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 10,),
              itemCount: ProfileData.length,
              itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.only( left: 10, bottom: 4,),
                    child:  InkWell(
                      onTap: (){
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                              color:  selectedIndex == index ? Colors.white :ColorApp.secondaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(ProfileData[index].icon),
                                const SizedBox(
                                  height: 3,),
                                Text(
                                   ProfileData[index].name,),
                        ]),
                      ),
                    ),
                  ),);
                },
            ),
        ),
      ),
    );
  }
}

class ProfileModel {
  final String name;
  final IconData icon;

  ProfileModel({
    required this.name,
    required this.icon,
  });
}
List ProfileData = [
  ProfileModel(name: "Profile", icon: Icons.person),
  ProfileModel(name: "favourite", icon: Icons.favorite),
  ProfileModel(name: "Payment", icon: Icons.monetization_on_outlined),
  ProfileModel(name: "Previous Trips", icon: Icons.business_center_rounded),
];