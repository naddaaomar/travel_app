import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/views/widgets/tabs/profile.dart';
import '../../../../../helpers/themes/colors.dart';
import 'fav_tab_widgets/no_fav.dart';
import 'trips_tab_widgets/no_trips.dart';

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
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 20,),
                  itemCount: ProfileData.length,
                  itemBuilder: (BuildContext context, int index) {
                      return Padding(
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
            child: ProfileScreen(name: 'n', value: 'n@gmail.com', pass: '********',));
      case 1:
        return const Center(
            child: NoFavorites());
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
  ProfileModel(name: "Previous Trips", icon: Icons.business_center_rounded),
];


