import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class PrivacySecurityWidget extends StatelessWidget {
  const PrivacySecurityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: _buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: PrivacySecurityContent.items
            .map((item) => _buildPrivacyRow(item, context))
            .toList(),
      ),
    );
  }

  Widget _buildPrivacyRow(PrivacyItem item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon,
              size: 22,
              color: Theme.of(context).iconTheme.color),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title.tr(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  item.description.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
class PrivacySecurityContent {
  static List<PrivacyItem> get items => [
    PrivacyItem(
      icon: Icons.lock_outline,
      title: "Data Encryption",
      description: "Enterprise-grade AES-256 encryption for all stored data",
    ),
    PrivacyItem(
      icon: Icons.location_off_outlined,
      title: "Location Data",
      description: "Precise location only used during active navigation",
    ),
    PrivacyItem(
      icon: Icons.credit_card_off,
      title: "Payment Security",
      description: "PCI-DSS Level 1 compliant payment processing",
    ),
    PrivacyItem(
      icon: Icons.verified_user,
      title: "Certifications",
      description: "SOC 2 Type II audited infrastructure",
    ),
  ];
}

class PrivacyItem {
  final IconData icon;
  final String title;
  final String description;

  PrivacyItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}