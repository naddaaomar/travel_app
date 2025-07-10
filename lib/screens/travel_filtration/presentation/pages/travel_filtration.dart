import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';

import '../manger/travel_filter_cubit.dart';

class TravelFiltration extends StatefulWidget {
  const TravelFiltration({super.key});

  @override
  State<TravelFiltration> createState() => _TravelFiltrationState();
}

//
class _TravelFiltrationState extends State<TravelFiltration> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TravelFilterCubit, TravelFilterState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = TravelFilterCubit.get(context);
        return GestureDetector(
          child: Stack(
            children: [
              // GestureDetector to close dropdown if tapped outside
              // GestureDetector(
              //   onTap: () {
              //     closeAll(); // Close both dropdowns when tapped outside
              //   },
              //   child: Container(
              //     color: Colors.red,
              //     width: (categoryDown || priceDown) ? double.infinity : 0,
              //     height: (categoryDown || priceDown)
              //         ? MediaQuery.of(context).size.height
              //         : 0, // Set height to screen height
              //   ),
              // ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cubit.toggleCategory();
                          },
                          child: FilterContainer(
                              txt: "Category", isDown: state.categoryDown),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            cubit.togglePrice();
                          },
                          child: FilterContainer(
                              txt: "Price", isDown: state.priceDown),
                        ),
                      ],
                    ),
                  ),
                  if (state.bottomContainer != null) state.bottomContainer!,
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class FilterContainer extends StatelessWidget {
  final String txt;
  final bool isDown;

  const FilterContainer({
    super.key,
    required this.txt,
    required this.isDown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 6,
            spreadRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
        gradient: LinearGradient(
          colors: [ColorApp.primaryColor, const Color(0xffAE4530)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            txt,
            style: const TextStyle(
              fontFamily: "pop",
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          Icon(
            isDown
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}