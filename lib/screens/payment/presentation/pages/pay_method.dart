import 'package:flutter/material.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/themes/colors.dart';

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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorApp.secondaryColor, size: 27),
        backgroundColor: ColorApp.primaryColor,
        shadowColor: Colors.transparent,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
            child: Image.asset(
              'assets/images/logo_2.png',
              width: 200,
              height: 100,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/images/instapay.png",
                  width: 130,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebScreen(
                        integrationId: Constants.CARD_ID,
                        fName: fName,
                        lName: lName,
                        phone: phone,
                        amount: amount * 100,
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  "assets/images/masterCard.png",
                  width: 130,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebScreen(
                          integrationId: Constants.CARD_ID,
                          fName: fName,
                          lName: lName,
                          phone: phone,
                          amount: amount * 100,
                        ),
                      ));
                },
                child: Image.asset(
                  "assets/images/visa.png",
                  width: 130,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/images/vodafone.png",
                  width: 130,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/images/payPal.png",
                  width: 130,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.primaryColor),
            child: Text(
              "Select a payment method",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
