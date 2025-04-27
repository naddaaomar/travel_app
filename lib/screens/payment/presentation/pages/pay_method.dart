import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/main.dart';
import 'package:p/models/paymet_methods_model.dart';
import 'package:p/screens/payment/presentation/widgets/pay_card.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';

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
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorApp.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h,),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 30.w,
                    color: ColorApp.secondaryColor,
                  )),
              SizedBox(height: 10.h,),
              Container(
                decoration: BoxDecoration(color: ColorApp.secondaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.r),
                  topLeft: Radius.circular(30.r)
                )),
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 20.h),
                  child: FadeInUp(
                    child: Column(
                      children: [
                        FadeInUp(
                          child: RichText(
                            textAlign: TextAlign.center,
                    
                            text: TextSpan(children: [
                              TextSpan(
                    
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color:
                                        isLight ? Colors.black : Colors.white,
                                  ),
                                  text: "Select "),
                              TextSpan(
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    color: isLight
                                        ? ColorApp.thirdColor
                                        : Colors.white,
                                  ),
                                  text: "PAYMENT METHOD")
                            ]),
                          ),
                        ),
                        FadeInUp(
                          child: Text(
                            textAlign: TextAlign.center,
                            "Just one step left to complete!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 12,),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebScreen(
                                        fName: fName,
                                        lName: lName,
                                        phone: phone,
                                        amount: amount * 100,
                                        integrationId: payModel[index].id,
                                      ),
                                    ));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
