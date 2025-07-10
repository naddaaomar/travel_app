import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';
import 'package:p/screens/booking/presentation/manager/booking_cubit.dart';
import 'package:p/screens/booking/presentation/widgets/done.dart';
import 'package:p/screens/booking/presentation/widgets/pay.dart';
import 'package:p/screens/trip_details/models/TravelDetailsModel.dart';

import '../../../../di.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({super.key, required this.model});

  TravelDetailsModel model;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var formKeyDone = GlobalKey<FormState>();
  var formKeyPay = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffE0D7D7),
              Color(0xffA28575),
            ],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocProvider(
            create: (context) => getIt<BookingCubit>()..init(),
            child: BlocConsumer<BookingCubit, BookingState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Stack(
                  children: [
                    SizedBox(
                      height: size.height * 0.35,
                      width: double.maxFinite,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20.r)),
                              image: DecorationImage(
                                image: (widget.model.coverImageUrl != null &&
                                        (widget.model.coverImageUrl)!
                                            .startsWith('http'))
                                    ? NetworkImage((widget.model.coverImageUrl)!)
                                    : const AssetImage(
                                            "assets/images/dahab1.jpg")
                                        as ImageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10.h,
                            left: 0.w,
                            child: FadeInUp(
                              duration: Duration(milliseconds: 1000),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(15.r)),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      iconSize: 20.w,
                                      icon: Icon(
                                        Ionicons.chevron_back,
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 230.h),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xffE0D7D7),
                                Color(0xffA28575),
                              ],
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.r),
                                topLeft: Radius.circular(20.r))),
                        child: state.showProgress
                            ? Center(
                                child: SizedBox(
                                width: 75,
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballZigZag,
                                  strokeWidth: 2,
                                  colors: [
                                    ColorApp.primaryColor,
                                    ColorApp.thirdColor
                                  ],
                                ),
                              ))
                            : state.isFormValid
                                ? Pay(keyPay: formKeyPay, model: widget.model)
                                : Done(
                                    keyDone: formKeyDone, model: widget.model)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
