import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:p/helpers/themes/colors.dart';

import '../manger/travel_filter_cubit.dart';

class PriceContainer extends StatefulWidget {
  final void Function(RangeValues? priceRange, String? priceOrder) onDone;
  final String? initialOrder;

  const PriceContainer({
    super.key,
    required this.onDone,
    this.initialOrder,
  });

// setState
  @override
  _PriceContainerState createState() => _PriceContainerState();
}

class _PriceContainerState extends State<PriceContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TravelFilterCubit, TravelFilterState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var filterCubit = TravelFilterCubit.get(context);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black54.withOpacity(0.3),
            //     blurRadius: 6,
            //     spreadRadius: 260,
            //     offset: const Offset(0, 277),
            //   ),
            // ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price range",
                style: TextStyle(
                    fontFamily: "pop",
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "EGP ${state.currentRangeValues.start.toStringAsFixed(0)}"),
                  Text(
                      "EGP ${state.currentRangeValues.end.toStringAsFixed(0)}"),
                ],
              ),
              RangeSlider(
                values: state.currentRangeValues,
                min: 700,
                max: 10000,
                activeColor: Color(0xff9A1A00),
                inactiveColor: ColorApp.primaryColor.withOpacity(0.3),
                onChanged: (RangeValues values) {
                  filterCubit.changeRange(values);
                  ;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Price Order",
                style: TextStyle(
                    fontFamily: "pop",
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PriceOrder(
                    txt: "Descending",
                    isSelected: state.selectedOrder == "Descending",
                    onTap: () {
                      filterCubit.selectPriceOrder("Descending");
                    },
                  ),
                  PriceOrder(
                    txt: "Ascending",
                    isSelected: state.selectedOrder == "Ascending",
                    onTap: () {
                      filterCubit.selectPriceOrder("Ascending");
                    },
                  )
                ],
              ),
              Text(
                "Default : Descending",
                style: TextStyle(
                    fontFamily: "pop",
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // CLEAR button with gradient border
                  Container(
                    height: 40,
                    margin: EdgeInsets.zero,
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
                          final isConnected = await Connectivity().checkConnectivity();

                          if (isConnected == ConnectivityResult.none) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'No internet connection',
                                  style: TextStyle(fontSize: 12, fontFamily: "pop"),
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 7,
                                backgroundColor: Color(0xff242931).withOpacity(.7),
                                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              ),
                            );
                            return;
                          }

                          filterCubit.clearPrice();
                          widget.onDone(
                              RangeValues(0, 100000), state.selectedOrder);
                        }
,
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
                          fontSize: 12,
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
                          final isConnected = await Connectivity().checkConnectivity();

                          if (isConnected == ConnectivityResult.none) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'No internet connection',
                                  style: TextStyle(fontSize: 12, fontFamily: "pop"),
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 7,
                                backgroundColor: Color(0xff242931).withOpacity(.7),
                                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              ),
                            );
                            return;
                          }

                          widget.onDone(
                              state.currentRangeValues, state.selectedOrder);
                        }
,
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
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class PriceOrder extends StatelessWidget {
  final String txt;
  final bool isSelected;
  final VoidCallback onTap;

  PriceOrder(
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
              color: isSelected ? Colors.white : Colors.black, fontSize: 13),
        ),
      ),
    );
  }
}
