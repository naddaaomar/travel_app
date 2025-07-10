import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/booking/presentation/manager/booking_cubit.dart';
import 'package:p/screens/booking/presentation/widgets/custom_text_field.dart';
import 'package:p/screens/trip_details/models/TravelDetailsModel.dart';

class Done extends StatelessWidget {
  Done({super.key, required this.keyDone, required this.model});
  final GlobalKey<FormState> keyDone;

  TravelDetailsModel model;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = BookingCubit.get(context);
        final bool hasInput = cubit.numPeopleController.text.isNotEmpty;
        final bool hasInputKids = cubit.kidsController.text.isNotEmpty;
        return SingleChildScrollView(
          child: Form(
            key: keyDone,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.title ?? "",
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
                      "Number Of Travelers",
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
                        isFocused: state.isFocusedPeople,
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

                          if (numValue > model.availableSeats!) {
                            return 'Only ${model.availableSeats} seats available';
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
                          "Kids Under Five Included ?",
                          style: TextStyle(
                            fontFamily: "pop",
                            fontSize: 12.5,
                          ),
                        ),
                        Spacer(),
                        Radio<int>(
                          activeColor: Colors.brown.shade500,
                          value: 0,
                          groupValue: state.selectedChoice,
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
                          groupValue: state.selectedChoice,
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
                  if (state.choiceStateTxt != null &&
                      state.selectedChoice == null)
                    (Text(
                      state.choiceStateTxt!,
                      style: TextStyle(
                          color: Colors.red, fontFamily: "pop", fontSize: 12),
                    )),
                  SizedBox(
                    height: 20,
                  ),
                  if (state.selectedChoice == 0)
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
                            isFocused: state.isFocusedKids,
                            validate: (value) {
                              if (value == null || value.trim().isEmpty) {
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
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () {
                            if (state.selectedChoice == null) {
                              cubit.choiceState();
                            }
                            if (keyDone.currentState!.validate()) {
                              if (state.selectedChoice == null) {
                                cubit.choiceState();
                                return;
                              }

                              // cubit.calculateTotalPrice(
                              //   pricePerPerson: model.price!,
                              //   // or your actual price
                              //   numPeopleController:
                              //       cubit.numPeopleController,
                              //   kidsController: cubit.kidsController,
                              //   fiveController: cubit.fiveController,
                              // );
                              // await cubit.bookingCall(
                              //     //   buyerEmail: "alaa@.com",
                              //     travelId: model.id!.toInt(),
                              //     quantity: int.parse(
                              //         cubit.numPeopleController.text));
                              if (!state.isDone) {
                                cubit.doneBooking(currentValue: state.isDone);

                                cubit.showProgressThenPay();
                              }

                              print("${state.isDone}");
                              return;
                            }
                            if (state.isDone == true) {
                              cubit.doneBooking(currentValue: state.isDone);
                              print("${state.isDone}");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffB96C5B),
                              elevation: 10),
                          child: Text(
                            "Done",
                            style: TextStyle(
                                fontFamily: "pop",
                                fontSize: 13,
                                color: Colors.white),
                          )),
                    ),
                  ),
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

                  // Center(
                  //   child: ElevatedButton(
                  //       onPressed: () async {
                  //         if (state.selectedChoice == null) {
                  //           cubit.choiceState();
                  //         }
                  //         if (keyDone.currentState!.validate()) {
                  //           if (state.selectedChoice == null) {
                  //             cubit.choiceState();
                  //             return;
                  //           }
                  //
                  //           // cubit.calculateTotalPrice(
                  //           //   pricePerPerson: widget.model.price!,
                  //           //   // or your actual price
                  //           //   numPeopleController:
                  //           //       cubit.numPeopleController,
                  //           //   kidsController: cubit.kidsController,
                  //           //   fiveController: cubit.fiveController,
                  //           // );
                            // await cubit.bookingCall(
                            //     //   buyerEmail: "alaa@.com",
                            //     travelId: widget.model.id!.toInt(),
                            //     quantity: int.parse(
                            //         cubit.numPeopleController.text));
                  //           if (!state.isDone) {
                  //             cubit.doneBooking(
                  //                 currentValue: state.isDone);
                  //           }
                  //
                  //           print("${state.isDone}");
                  //           return;
                  //         }
                  //         if (state.isDone == true) {
                  //           cubit.doneBooking(
                  //               currentValue: state.isDone);
                  //           print("${state.isDone}");
                  //         }
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //           backgroundColor: state.isDone
                  //               ? Color(0xff794242)
                  //               : Color(0xff866F6F)),
                  //       child: (state.isLoading)
                  //           ? CircularProgressIndicator(
                  //               color: Colors.white,
                  //               value: 2,
                  //             )
                  //           : Text(
                  //               "Pay",
                  //               style: TextStyle(
                  //                   fontFamily: "pop",
                  //                   color: Colors.white),
                  //             )),
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
