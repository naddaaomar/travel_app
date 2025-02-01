import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/nearby_places.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/companies.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/offer_card.dart';

class CompanyOffers extends StatelessWidget {
  CompanyModel companyModel;
  CompanyOffers({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: isLight?ColorApp.secondaryColor:Colors.white,),
          title: Text(
            companyModel.label,
            style: TextStyle(
                color: isLight?ColorApp.secondaryColor:Colors.white, fontWeight: FontWeight.w500),
          ),
          backgroundColor: isLight?ColorApp.primaryColor:ColorApp.primaryColorDark,
          elevation: 5,
          shadowColor: isLight?ColorApp.primaryColor:ColorApp.primaryColorDark,
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
