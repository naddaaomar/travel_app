import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  const ProfileItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: ColorApp.primaryColor),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: onTap != null
          ? IconButton(
           icon: const Icon(
               Icons.edit,
               size: 20),
           onPressed: onTap,
          ): null,
      onTap: onTap,
    );
  }
}