import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/fav_tab_widgets/presentation/pages/fav.dart';
import '../../../../../helpers/themes/colors.dart';
import 'profile_tabs/profile_tab_widgets/presentation/pages/profile.dart';
import 'profile_tabs/payment_tab_widgets/presentation/pages/payment_tab.dart';
import 'profile_tabs/profile_tab_widgets/presentation/manager/profile_cubit.dart';
import 'profile_tabs/trips_tab_widgets/presentation/pages/trips.dart';

class ProfileBody extends StatefulWidget {
  final String? token;
  final String name;
  final String email;

  const ProfileBody({
    super.key,
    required this.token,
    required this.name,
    required this.email,
  });

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with SingleTickerProviderStateMixin {

  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..loadProfile(
        widget.name,
        widget.email,
        '',
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 40, right: 40, top:64),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
              ),
              child: SizedBox(
                height: 20,
                child: Row(
                  children: ProfileData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 4),
                        child: InkWell(
                          onTap: () {
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
                                  color: selectedIndex == index
                                      ? Colors.white
                                      : ColorApp.secondaryColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(ProfileData[index].icon),
                                  const SizedBox(height: 3),
                                  Builder(
                                    builder: (context) {
                                      final words = ProfileData[index].name.split(' ');
                                      if (words.length > 1) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: words.map((word) =>
                                              Text(
                                                word,
                                                style: const TextStyle(fontFamily: "vol"),
                                                textAlign: TextAlign.center,
                                              )
                                          ).toList(),
                                        );
                                      }
                                      return Text(
                                        ProfileData[index].name,
                                        style: const TextStyle(fontFamily: "vol"),
                                        textAlign: TextAlign.center,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Expanded(
            child: _buildSelectedContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (selectedIndex) {
      case 0:
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded || state is ProfilePasswordUpdated) {
              final profile = (state is ProfileLoaded)
                  ? state.profile
                  : (state as ProfilePasswordUpdated).profile;
              return Center(
                child: ProfileScreen(
                  name: profile.name,
                  email: profile.email,
                  password: profile.password,
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },);

      case 1:
        return const Center(child: FavoritesPage());

      case 2:
        return Center(child: PreviousTripsPage());

      case 3:
        return const Center(child: PaymentTab());

      default:
        return Container();
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

final List<ProfileModel> ProfileData = [
  ProfileModel(name: "Profile", icon: Icons.person),
  ProfileModel(name: "Favorite", icon: Icons.favorite),
  ProfileModel(name: "Previous Trips", icon: Icons.u_turn_right_outlined),
  ProfileModel(name: "Payment History", icon: Icons.monetization_on_outlined),
];