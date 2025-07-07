import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/booking/presentation/manager/booking_cubit.dart';
import 'package:p/screens/booking/presentation/widgets/custom_text_field.dart';
import 'package:p/screens/payment/presentation/pages/pay_method.dart';
import 'package:p/screens/trip_details/models/TravelDetailsModel.dart';

import '../../../../di.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({super.key, required this.model});

  TravelDetailsModel model;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
            leading: FadeIn(
              duration: Duration(milliseconds: 1500),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                ),
              ),
            ),
            title: FadeIn(
              duration: Duration(milliseconds: 1500),
              child: Text(
                "Booking Details",
                style: TextStyle(
                    fontFamily: "pop", color: Colors.black, fontSize: 16),
              ),
            ),
            centerTitle: true,
          ),
          body: BlocProvider(
            create: (context) => getIt<BookingCubit>()..init(),
            child: BlocConsumer<BookingCubit, BookingState>(
              listener: (context, state) {
                if (state is BookingSuccess) {
                  final cubit = BookingCubit.get(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayMethod(
                            bookingId: state.bookingModel.id!,
                            amount: state.bookingModel.totalCost!,
                            people: cubit.getSummaryText()),
                      ));
                }
              },
              builder: (context, state) {
                final cubit = BookingCubit.get(context);
                final bool hasInput = cubit.numPeopleController.text.isNotEmpty;
                final bool hasInputKids = cubit.kidsController.text.isNotEmpty;
                final bool hasInputFive = cubit.fiveController.text.isNotEmpty;
                final summary = cubit.getSummaryText();
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Next stop → ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "pop",
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.model.title ?? "",
                                        style: TextStyle(
                                          fontFamily: "pop",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          FadeInUp(
                            duration: Duration(milliseconds: 1175),
                            child: Text(
                              "Number of Travelers",
                              style: TextStyle(
                                  fontFamily: "pop",
                                  fontSize: 14,
                                  color: ColorApp.thirdColor),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FadeInUp(
                              duration: Duration(milliseconds: 1350),
                              child: CustomTextField(
                                controller: cubit.numPeopleController,
                                focusNode: cubit.focusNodePeople,
                                hintText: "Enter a number",
                                hasInput: hasInput,
                                isFocused: cubit.isFocusedPeople,
                                validate: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter a number';
                                  }

                                  final numValue = int.tryParse(value);
                                  if (numValue == null) {
                                    return 'Please enter a valid number';
                                  }
                                  if (numValue == 0) {
                                    return "value can't be zero";
                                  }

                                  if (numValue > widget.model.availableSeats!) {
                                    return 'Only ${widget.model.availableSeats} seats available';
                                  }

                                  return null; // Valid input
                                },
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          FadeInUp(
                            duration: Duration(milliseconds: 1525),
                            child: Row(
                              children: [
                                Text(
                                  "Kids Included ?",
                                  style: TextStyle(
                                    fontFamily: "pop",
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(),
                                Radio<int>(
                                  activeColor: Colors.brown.shade500,
                                  value: 0,
                                  groupValue: cubit.selectedChoice,
                                  onChanged: (int? value) {
                                    cubit.selectedKids(num: value);
                                  },
                                ),
                                Text(
                                  "Yes",
                                  style: TextStyle(
                                    fontFamily: "pop",
                                    fontSize: 13,
                                  ),
                                ),
                                Radio<int>(
                                  activeColor: Colors.brown.shade500,
                                  value: 1,
                                  groupValue: cubit.selectedChoice,
                                  onChanged: (int? value) {
                                    cubit.selectedKids(num: value);
                                  },
                                ),
                                Text(
                                  "No",
                                  style: TextStyle(
                                    fontFamily: "pop",
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (cubit.choiceStateTxt != null &&
                              cubit.selectedChoice == null)
                            (Text(
                              cubit.choiceStateTxt!,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "pop",
                                  fontSize: 12),
                            )),
                          SizedBox(
                            height: 20,
                          ),
                          if (cubit.selectedChoice == 0)
                            (Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeInUp(
                                  duration: Duration(milliseconds: 1000),
                                  child: Text(
                                    "How many kids ?",
                                    style: TextStyle(
                                        fontFamily: "pop",
                                        color: ColorApp.thirdColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FadeInUp(
                                  duration: Duration(milliseconds: 1200),
                                  child: CustomTextField(
                                    controller: cubit.kidsController,
                                    focusNode: cubit.focusNodeKids,
                                    hintText: "Enter a number of kids",
                                    hasInput: hasInputKids,
                                    isFocused: cubit.isFocusedKids,
                                    validate: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please enter a number';
                                      }

                                      final numValue = int.tryParse(value);
                                      if (numValue == null) {
                                        return 'Please enter a valid number';
                                      }

                                      return null; // Valid input
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                FadeInUp(
                                  duration: Duration(milliseconds: 1000),
                                  child: Text(
                                    "How many kids under 5 years?",
                                    style: TextStyle(
                                        fontFamily: "pop",
                                        color: ColorApp.thirdColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FadeInUp(
                                    duration: Duration(milliseconds: 1200),
                                    child: CustomTextField(
                                      controller: cubit.fiveController,
                                      focusNode: cubit.focusNodeFive,
                                      hintText: "Enter a number of kids",
                                      hasInput: hasInputFive,
                                      isFocused: cubit.isFocusedFive,
                                      validate: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter a number';
                                        }

                                        final numValue = int.tryParse(value);
                                        if (numValue == null) {
                                          return 'Please enter a valid number';
                                        }

                                        return null; // Valid input
                                      },
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                FadeInUp(
                                  child: Text(
                                    "Kids under 5 years get 50% off",
                                    style: TextStyle(
                                        fontFamily: "pop",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.brown),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            )),
                          // FadeInUp(
                          //   duration: Duration(milliseconds: 1700),
                          //   child: Align(
                          //     alignment: Alignment.topRight,
                          //     child: ElevatedButton(
                          //         onPressed: () {
                          //           if (cubit.selectedChoice == null) {
                          //             cubit.choiceState();
                          //             return;
                          //           }
                          //           if (formKey.currentState!.validate()) {
                          //             if (cubit.selectedChoice == null) {
                          //               cubit.choiceState();
                          //               return;
                          //             }
                          //
                          //             cubit.calculateTotalPrice(
                          //               pricePerPerson: widget.model.price!,
                          //               // or your actual price
                          //               numPeopleController: cubit
                          //                   .numPeopleController,
                          //               kidsController: cubit.kidsController,
                          //               fiveController: cubit.fiveController,
                          //             );
                          //             if (!cubit.isDone) {
                          //               cubit.doneBooking(
                          //                   currentValue: cubit.isDone);
                          //             }
                          //
                          //             print("${cubit.isDone}");
                          //             return;
                          //           }
                          //           if (cubit.isDone == true) {
                          //             cubit.doneBooking(
                          //                 currentValue: cubit.isDone);
                          //             print("${cubit.isDone}");
                          //           }
                          //         },
                          //         style: ElevatedButton.styleFrom(
                          //             backgroundColor: Color(0xffB96C5B),
                          //             elevation: 10),
                          //         child: Text(
                          //           "Done",
                          //           style: TextStyle(
                          //               fontFamily: "pop",
                          //               fontSize: 13,
                          //               color: Colors.white),
                          //         )),
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          // if (summary.isNotEmpty)
                          //   (Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         summary,
                          //         style: TextStyle(
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.w500,
                          //             fontFamily: "pop"),
                          //       ),
                          //       Text(
                          //         'Total Price: EGP ${cubit.totalPrice.toStringAsFixed(2)}',
                          //         style: TextStyle(
                          //           fontSize: 13,
                          //           fontFamily: "pop",
                          //         ),
                          //       ),
                          //     ],
                          //   )),
                          SizedBox(
                            height: 15,
                          ),

                          Center(
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (cubit.selectedChoice == null) {
                                    cubit.choiceState();
                                  }
                                  if (formKey.currentState!.validate()) {
                                    if (cubit.selectedChoice == null) {
                                      cubit.choiceState();
                                      return;
                                    }

                                    cubit.calculateTotalPrice(
                                      pricePerPerson: widget.model.price!,
                                      // or your actual price
                                      numPeopleController:
                                          cubit.numPeopleController,
                                      kidsController: cubit.kidsController,
                                      fiveController: cubit.fiveController,
                                    );
                                    await cubit.bookingCall(
                                        //   buyerEmail: "alaa@.com",
                                        travelId: widget.model.id!.toInt(),
                                        quantity: int.parse(
                                            cubit.numPeopleController.text));
                                    if (!cubit.isDone) {
                                      cubit.doneBooking(
                                          currentValue: cubit.isDone);
                                    }

                                    print("${cubit.isDone}");
                                    return;
                                  }
                                  if (cubit.isDone == true) {
                                    cubit.doneBooking(
                                        currentValue: cubit.isDone);
                                    print("${cubit.isDone}");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: cubit.isDone
                                        ? Color(0xff794242)
                                        : Color(0xff866F6F)),
                                child: (state is BookingLoading)
                                    ? CircularProgressIndicator(color: Colors.white,value: 2,)
                                    : Text(
                                        "Pay",
                                        style: TextStyle(
                                            fontFamily: "pop",
                                            color: Colors.white),
                                      )),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
