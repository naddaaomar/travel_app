import 'package:flutter/material.dart';
import 'package:p/screens/company_profile/widgets/tabs/tab_two.dart';
import 'package:p/screens/company_profile/widgets/tabs/trip_card.dart';

class TabFour extends StatelessWidget {
  const TabFour({super.key});

  @override
  Widget build(BuildContext context) {
    return TabTwo(card: TripCard(),);
  }
}
