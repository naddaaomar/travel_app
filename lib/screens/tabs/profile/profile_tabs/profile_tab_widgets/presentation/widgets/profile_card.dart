import 'package:flutter/material.dart';
import '../../data/model/user_profile_model.dart';
import 'profile_item.dart';

class ProfileCard extends StatelessWidget {
  final UserProfile profile;
  final Function() onEditName;
  final Function() onEditEmail;
  final Function() onEditPassword;

  const ProfileCard({
    super.key,
    required this.profile,
    required this.onEditName,
    required this.onEditEmail,
    required this.onEditPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileItem(
              title: 'Username',
              value: profile.name,
              icon: Icons.person,
              onTap: onEditName,
            ),
            const Divider(height: 24),
            ProfileItem(
              title: 'Email',
              value: profile.email,
              icon: Icons.email,
              onTap: onEditEmail,
            ),
            const Divider(height: 24),
            ProfileItem(
              title: 'Password',
              value: '*' * profile.passwordLength,
              icon: Icons.lock,
              onTap: onEditPassword,
            ),
          ],
        ),
      ),
    );
  }
}