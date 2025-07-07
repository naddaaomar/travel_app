import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/all_companies/presentation/manager/all_com_cubit.dart';

class RatingView extends StatelessWidget {
  const RatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllComCubit, AllComState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AllComCubit.get(context);
        return GestureDetector(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cubit.toggleRating();
                          },
                          child: FilterContainer(
                              txt: "Rating", isDown: state.ratingDown),
                        ),
                        const SizedBox(width: 20),
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
