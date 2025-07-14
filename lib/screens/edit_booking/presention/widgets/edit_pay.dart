import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';
import 'package:p/screens/booking/presentation/manager/booking_cubit.dart';
import 'package:p/screens/edit_booking/presention/manger/edit_booking_cubit.dart';
import 'package:p/screens/payment/presentation/pages/pay_method.dart';
import 'package:p/screens/trip_details/models/TravelDetailsModel.dart';
import '../../../booking/presentation/widgets/custom_text_field.dart';

class EditPay extends StatelessWidget {
  EditPay(
      {super.key,
      required this.keyPay,
      required this.model,
      required this.getBookingModel});
  final GlobalKey<FormState> keyPay;
  TravelDetailsModel? model;
  GetBookingModel getBookingModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditBookingCubit, EditBookingState>(
      listener: (context, stateEditing) {
        // if (stateEditing.bookingModelEdit != null &&
        //     stateEditing.isLoading == false &&
        //     stateEditing.error == null) {
        //   final cubit = EditBookingCubit.get(context);
        //   print("aaaaaaahhhhhhhhhhhhhhhh");
        //
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => PayMethod(
        //           bookingId: stateEditing.bookingModelEdit?.id ?? 0,
        //           amount: stateEditing.bookingModelEdit?.totalCost ?? 0,
        //           people: cubit.getSummaryText(),
        //           bookingModel: stateEditing.bookingModelEdit,
        //         ),
        //       ));
        // }
      },
      builder: (context, stateEditing) {
        final cubitEdit = EditBookingCubit.get(context);
        final cubitBooking = BookingCubit.get(context);
        final bool hasInputPhone = cubitEdit.phoneController.text.isNotEmpty;
        final bool hasInputId = cubitEdit.idController.text.isNotEmpty;

        return BlocConsumer<BookingCubit, BookingState>(
          listener: (context, stateBooking) {
            if (stateBooking.bookingModel != null &&
                stateBooking.isLoading == false &&
                stateBooking.error == null) {
              final cubit = BookingCubit.get(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PayMethod(
                      popCount: 2,
                      bookingId: stateBooking.bookingModel?.id ?? 0,
                      amount: stateBooking.bookingModel?.totalCost ?? 0,
                      people: cubit.getSummaryText(),
                      bookingModel: stateBooking.bookingModel,

                    ),
                  ));
            }
          },
          builder: (context, stateBooking) {
            final cubitPut = BookingCubit.get(context);
            return SingleChildScrollView(
              child: Form(
                key: keyPay,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                    model?.title ?? "",
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
                          controller: cubitEdit.idController,
                          focusNode: cubitEdit.focusNodeId,
                          hintText: "Enter your national ID",
                          hasInput: hasInputId,
                          isFocused: stateEditing.isFocusedId,
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
                          controller: cubitEdit.phoneController,
                          focusNode: cubitEdit.focusNodePhone,
                          hintText: "Enter your phone number",
                          hasInput: hasInputPhone,
                          isFocused: stateEditing.isFocusedPhone,
                          validate: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your phone number';
                            }
                            final regex =
                                RegExp(r'^(010|011|012|015)[0-9]{8}$');
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
                              if (stateEditing.selectedChoice == null) {
                                cubitEdit.choiceState();
                              }
                              if (keyPay.currentState!.validate()) {
                                if (stateEditing.selectedChoice == null) {
                                  cubitEdit.choiceState();
                                  return;
                                }
                                await cubitPut.bookingPut(
                                  bookingId: getBookingModel.id!.toInt(),
                                  travelId: getBookingModel.bookingItem?.travelId?.toInt() ?? 0,
                                  nationalId: cubitEdit.idController.text,
                                  totalQuantity: int.tryParse(
                                      cubitEdit.numPeopleController.text.trim()) ??
                                      0,
                                  phoneNumber: cubitEdit.phoneController.text,
                                  childrenUnderFiveNum: int.tryParse(
                                      cubitEdit.kidsController.text.trim()) ??
                                      0,
                                );
                                print("aaaaaaaaaaaaahhhhhhhhhhhhhhhh");
                                EditBookingCubit.get(context).isEditDone();
                                if (!stateEditing.isDone) {
                                  cubitEdit.doneBooking(
                                      currentValue: stateEditing.isDone);
                                }

                                print("${stateEditing.isDone}");
                                return;
                              }
                              if (stateEditing.isDone == true) {
                                cubitEdit.doneBooking(
                                    currentValue: stateEditing.isDone);
                                print("${stateEditing.isDone}");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: stateEditing.isDone
                                    ? Color(0xff794242)
                                    : Color(0xff866F6F)),
                            child: (stateEditing.isLoading)
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                    value: 2,
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
      },
    );
  }
}
