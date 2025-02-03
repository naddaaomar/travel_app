import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/models/paymet_methods_model.dart';
import 'package:p/screens/payment/presentation/widgets/pay_card.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';

import 'pay_screens/web_screen.dart';

class PayMethod extends StatelessWidget {
  String fName;
  String lName;
  String phone;
  double amount;

  PayMethod(
      {super.key,
      required this.fName,
      required this.lName,
      required this.phone,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(170), // Make half circle
                      bottomRight: Radius.circular(170),
                    ),
                    color: ColorApp.primaryColor),
                child: Center(
                    child: FadeInUp(
                        child: Text(
                  "Select a payment method",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ))),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                 return InkWell(
                   onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => WebScreen(
                       fName: fName,
                       lName: lName,
                       phone: phone,
                       amount: amount*100,
                       integrationId: payModel[index].id,
                     ),));
                   },
                   child: PayCard(
                      image: payModel[index].image,
                    ),
                 );
                },
                itemCount: payModel.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}
