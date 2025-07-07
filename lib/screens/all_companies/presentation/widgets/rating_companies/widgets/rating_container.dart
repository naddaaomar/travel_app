import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:p/screens/all_companies/presentation/manager/all_com_cubit.dart';

class RatingContainer extends StatelessWidget {
  const RatingContainer({super.key, required this.onDone});

  final void Function(int? rate, String? sort) onDone;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllComCubit, AllComState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = AllComCubit.get(context);
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Rating",
                  style: TextStyle(
                      fontFamily: "pop",
                      fontSize: 13.5,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                ...List.generate(5, (index) {
                  int rating = index + 1;
                  return GestureDetector(
                    onTap: () {
                      cubit.selectRating(rating);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: state.selectedRating == rating
                            ? const Color(0xffEAD4D0)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(
                        //   color: selectedRating == rating
                        //       ? const Color(0xff9A1A00)
                        //       : Colors.grey.shade400,
                        //   width: 1.5,
                        // ),
                      ),
                      child: Row(
                        children: [
                          // Stars
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              rating,
                              (starIndex) => Icon(
                                Icons.star,
                                color: state.selectedRating == rating
                                    ? Colors.yellow
                                    : Colors.yellow.shade800,
                                size: 18,
                              ),
                            ),
                          ),
                          const Spacer(),
                          // Square radio-like check
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: state.selectedRating == rating
                                    ? const Color(0xff9A1A00)
                                    : Colors.grey,
                                width: 2,
                              ),
                              color: state.selectedRating == rating
                                  ? const Color(0xff9A1A00)
                                  : Colors.transparent,
                            ),
                            child: state.selectedRating == rating
                                ? const Icon(Icons.check,
                                    size: 14, color: Colors.white)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Rating order",
                  style: TextStyle(
                      fontFamily: "pop",
                      fontSize: 13.5,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingOrder(
                      txt: "Descending",
                      isSelected: state.selectedRatingOrder == "Descending",
                      onTap: () {
                        cubit.selectRatingOrder("Descending");
                      },
                    ),
                    RatingOrder(
                      txt: "Ascending",
                      isSelected: state.selectedRatingOrder == "Ascending",
                      onTap: () {
                        cubit.selectRatingOrder("Ascending");
                      },
                    )
                  ],
                ),
                Text(
                  "Default : Descending",
                  style: TextStyle(
                      fontFamily: "pop",
                      fontSize: 11,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: GradientBoxBorder(
                          width: 2,
                          gradient: const LinearGradient(
                            colors: [Color(0xffE3AE94), Color(0xffFF2B00)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          final isConnected =
                              await Connectivity().checkConnectivity();

                          if (isConnected == ConnectivityResult.none) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'No internet connection',
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
                            return;
                          }

                          cubit.clearRating();
                          onDone(null, null);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text(
                          "Clear",
                          style: TextStyle(
                            fontFamily: "pop",
                            fontSize: 11,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [Color(0xffE3AE94), Color(0xffFF2B00)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          final isConnected =
                              await Connectivity().checkConnectivity();

                          if (isConnected == ConnectivityResult.none) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'No internet connection',
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
                            return;
                          }

                          // Continue only if connected
                          onDone(
                              state.selectedRating, state.selectedRatingOrder);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text(
                          "Done",
                          style: TextStyle(
                            fontFamily: "pop",
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class RatingOrder extends StatelessWidget {
  final String txt;
  final bool isSelected;
  final VoidCallback onTap;

  RatingOrder(
      {super.key,
      required this.txt,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? Colors.transparent : Color(0xffD67561),
              width: isSelected ? 2 : 2),
          color: isSelected ? Color(0xffD67561) : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          txt,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black, fontSize: 11.5),
        ),
      ),
    );
  }
}
