import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/di.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/booking/presentation/manager/booking_cubit.dart';

Future<bool> backDialog({
  required BuildContext context,
  required int bookingId,
 required int popCount , // 👈 Add this
}) {
  return showDialog<bool>(
    context: context,
    barrierColor: Colors.black54,
    barrierDismissible: true,
    builder: (dialogContext) {
      return BlocProvider(
        create: (context) => getIt<BookingCubit>(),
        child: BlocConsumer<BookingCubit, BookingState>(
          listener: (context, state) {
            if (state is BookingDeleteSuccess) {
              Navigator.of(dialogContext).pop(true);

              Future.microtask(() {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Booking deleted successfully.',
                      style: TextStyle(fontSize: 12, fontFamily: "pop"),
                      textAlign: TextAlign.center,
                    ),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 7,
                    backgroundColor: Color(0xff242931).withOpacity(.7),
                    margin:
                    EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                );

                int count = 0;
                Navigator.of(context).popUntil((route) {
                  return count++ >= popCount;
                });
              });
            }
          },
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: ColorApp.secondaryColor,
              title: Text(
                "Leave Payment?",
                style: TextStyle(fontFamily: "pop", fontSize: 18),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "You're about to leave the payment screen. Would you like to cancel your booking or keep it pending to complete payment later?",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "pop",
                        color: Colors.black54),
                  ),
                ],
              ),
              actions: [
                Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        elevation: 7,
                        backgroundColor: Color(0xff8A2626),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () async {
                        await BookingCubit.get(context)
                            .bookingDelete(bookingId: bookingId);
                      },
                      child: Text(
                        "Cancel Booking",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: "pop"),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        elevation: 7,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        backgroundColor: Color(0xffB96C5B),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext).pop(true);

                        Future.microtask(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'You can complete your payment anytime from your profile',
                                style: TextStyle(
                                    fontSize: 12, fontFamily: "pop"),
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 7,
                              backgroundColor:
                              Color(0xff242931).withOpacity(.7),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                            ),
                          );

                          int count = 0;
                          Navigator.of(context).popUntil((route) {
                            return count++ >= popCount;
                          });
                        });
                      },
                      child: Text(
                        "Keep Pending",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: "pop"),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      );
    },
  ).then((value) => value ?? false);
}
