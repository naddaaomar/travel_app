import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportWidget extends StatelessWidget {
  const HelpSupportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: _buildBoxDecoration(),
      child: Column(
        children: [
          _buildSupportOption(
            context,
            icon: Icons.email_outlined,
            label: "Contact Us",
            value: "support@journeymate.app",             //waiting for web for real link
            onTap: () => _launchEmail(),
            isLight: isLight,
          ),
          SizedBox(height: 16),
          _buildSupportOption(
            context,
            icon: Icons.language_outlined,
            label: "Website",
            value: "journeymate.app/help",             //waiting for web for real link
            onTap: () => _launchWebsite(),
            isLight: isLight,
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOption(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        required VoidCallback onTap,
        required bool isLight,
      }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon,
              size: 24,
              color: Colors.black),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isLight
                        ? Colors.black.withOpacity(0.7)
                        : Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right,
              color: Colors.black.withOpacity(0.5)),
        ],
      ),
    );
  }

  Future<void> _launchEmail() async {
    final uri = Uri.parse("mailto:support@journeymate.app");                    //waiting for web for real link
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchWebsite() async {
    final uri = Uri.parse("https://journeymate.app/help");                      //waiting for web for real link
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      border: GradientBoxBorder(
        gradient: LinearGradient(colors: const [
          Color(0xffFFB184),
          Color(0xff7F5E41),
        ]),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}