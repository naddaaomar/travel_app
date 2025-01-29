import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/nearby_places.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/companies.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/offer_card.dart';

class CompanyOffers extends StatelessWidget {
  CompanyModel companyModel;
  CompanyOffers({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorApp.secondaryColor),
          title: Text(
            companyModel.label,
            style: TextStyle(
                color: ColorApp.secondaryColor, fontWeight: FontWeight.w500),
          ),
          backgroundColor: ColorApp.primaryColor,
          elevation: 5,
          shadowColor: ColorApp.primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
               OfferCar(),
            ],
          ),
        ),
      ),
    );
  }
}
