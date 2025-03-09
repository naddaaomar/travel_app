import 'package:flutter/material.dart';
import 'package:p/screens/company_profile/widgets/tabs/discount_card.dart';
import 'package:p/screens/company_profile/widgets/tabs/tab_two.dart';

class TabThree extends StatelessWidget {
  const TabThree({super.key});

  @override
  Widget build(BuildContext context) {
    return TabTwo(card: DiscountCard(),);
  }
}
