import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/booking/presentation/manager/booking_cubit.dart';
import 'package:p/screens/payment/presentation/pages/pay_method.dart';
import 'package:p/screens/trip_details/models/TravelDetailsModel.dart';
import 'custom_text_field.dart';

class Pay extends StatelessWidget {
  Pay({super.key, required this.keyPay, required this.model});
  final GlobalKey<FormState> keyPay;
  TravelDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state.bookingModel != null &&
            state.isLoading == false &&
            state.error == null) {
          final cubit = BookingCubit.get(context);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PayMethod(
                  popCount: 2,
                    bookingId: state.bookingModel?.id ?? 0,
                    amount: state.bookingModel?.totalCost ?? 0,
                    people: cubit.getSummaryText(),
                bookingModel: state.bookingModel,),
              ));
        }
      },
      builder: (context, state) {
        final cubit = BookingCubit.get(context);
        final bool hasInputPhone = cubit.phoneController.text.isNotEmpty;
        final bool hasInputId = cubit.idController.text.isNotEmpty;

        return SingleChildScrollView(
          child: Form(
            key: keyPay,
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
                  SizedBox(height: 35),

                  /// National ID
                  FadeInUp(
                    duration: Duration(milliseconds: 1175),
                    child: Text(
                      "Enter your National ID",
                      style: TextStyle(
                        fontFamily: "pop",
                        fontSize: 14,
                        color: ColorApp.thirdColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeInUp(
                    duration: Duration(milliseconds: 1350),
                    child: CustomTextField(
                      controller: cubit.idController,
                      focusNode: cubit.focusNodeId,
                      hintText: "Enter your national ID",
                      hasInput: hasInputId,
                      isFocused: state.isFocusedId,
                      validate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your National ID';
                        }
                        final regex = RegExp(r'^[23]\d{13}$');
                        if (!regex.hasMatch(value.trim())) {
                          return 'Please enter a valid Egyptian National ID';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),

                  /// Phone Number
                  FadeInUp(
                    duration: Duration(milliseconds: 1525),
                    child: Text(
                      "Enter your Phone Number",
                      style: TextStyle(
                        fontFamily: "pop",
                        fontSize: 14,
                        color: ColorApp.thirdColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: CustomTextField(
                      controller: cubit.phoneController,
                      focusNode: cubit.focusNodePhone,
                      hintText: "Enter your phone number",
                      hasInput: hasInputPhone,
                      isFocused: state.isFocusedPhone,
                      validate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your phone number';
                        }
                        final regex = RegExp(r'^(010|011|012|015)[0-9]{8}$');
                        if (!regex.hasMatch(value.trim())) {
                          return 'Please enter a valid Egyptian phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),

                  FadeInUp(
                    duration: Duration(milliseconds: 1900),
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (state.selectedChoice == null) {
                            cubit.choiceState();
                          }
                          if (keyPay.currentState!.validate()) {
                            if (state.selectedChoice == null) {
                              cubit.choiceState();
                              return;
                            }
                            await cubit.bookingPost(
                              travelId: model.id?.toInt() ?? 0,
                              nationalId: cubit.idController.text,
                              totalQuantity: int.tryParse(
                                      cubit.numPeopleController.text.trim()) ??
                                  0,
                              phoneNumber: cubit.phoneController.text,
                              childrenUnderFiveNum: int.tryParse(
                                      cubit.kidsController.text.trim()) ??
                                  0,
                            );
                            if (!state.isDone) {
                              cubit.doneBooking(currentValue: state.isDone);
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
                            backgroundColor: state.isDone
                                ? Color(0xff794242)
                                : Color(0xff866F6F)),
                        child: (state.isLoading)
                            ? SizedBox(
                          width: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white,

                                  value: 2,
                                ),
                            )
                            : Text(
                                "Pay",
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
