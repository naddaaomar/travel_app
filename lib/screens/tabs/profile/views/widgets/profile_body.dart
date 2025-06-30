import 'package:flutter/material.dart';
import '../../../../../helpers/themes/colors.dart';
import 'profile_tabs/fav_tab_widgets/no_fav.dart';
import 'profile_tabs/profile.dart';
import 'profile_tabs/trips_tab_widgets/no_trips.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key, required token});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with SingleTickerProviderStateMixin {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40 ,right: 40 ,top: 96),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
            ),
            child: SizedBox(
              height: 20,
              child: Row(
                children:
                ProfileData.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only( left: 20, bottom: 4,),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color:  selectedIndex == index ? Colors.white :ColorApp.secondaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(ProfileData[index].icon),
                                  const SizedBox(
                                    height: 3,),
                                  Center(
                                    child: Text(
                                      ProfileData[index].name,
                                      style: TextStyle(
                                        fontFamily: "vol",
                                      ),),
                                  ),
                                ]),
                          ),
                        ),
                      ),),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        SizedBox(height: 80,),
        Expanded(
          child: _buildSelectedContent(),
        ),
      ],
    );
  }

  Widget _buildSelectedContent() {
    switch (selectedIndex) {
      case 0:
        return const Center(
            child: ProfileScreen(name: '',  email: '', password: '',));
      case 1:
        return Center(
            child: NoFavorites(onAddFavorite: (){},));
      case 2:
        return const Center(
            child: NoPreviousTrips());
      default:
        return Container(); // Default case
    }
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
  ProfileModel(name: "favorite", icon: Icons.favorite),
  ProfileModel(name: "Previous Trips", icon: Icons.u_turn_right_outlined),
];


