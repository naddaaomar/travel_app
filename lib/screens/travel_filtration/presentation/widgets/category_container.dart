import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../manger/travel_filter_cubit.dart';

class CategoryContainer extends StatefulWidget {
  const CategoryContainer({super.key, required this.onDone});

  final void Function(int? category) onDone;

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TravelFilterCubit, TravelFilterState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TravelFilterCubit.get(context);
        final categoriesWithIds = <Map<String, dynamic>>[
          {"id": null, "name": "All"},
          ...?state.categoryModel
              ?.map((e) => {"id": e.id, "name": e.categoryName}),
        ];

        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 13),
                child: Text(
                  "Category",
                  style: TextStyle(
                      fontFamily: "pop",
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 0,
                runSpacing: 10,
                children: categoriesWithIds.map((cat) {
                  final catId = cat["id"] as int?;
                  final catName = cat["name"] as String;

                  final bool isSelected = catId == state.selectedCategories;

                  return GestureDetector(
                    key: ValueKey(
                        catId ?? 'all'), // هذا مهم لإعادة البناء السليم
                    onTap: () {
                      cubit.setSelectedCategory(catId);
                    },

                    child: SelectCategory(
                      category: catName,
                      isSelected: isSelected,
                      showClearIcon: isSelected && catId != null,
                      onClear: cubit.clearCategory,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
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
                    child: Builder(
                        builder: (context) {
                          return ElevatedButton(
                            onPressed: () async {
                              final isConnected =
                              await Connectivity().checkConnectivity();
                              print(isConnected);
                              print(isConnected);
                              print(isConnected);
                              print(isConnected);
                              print(isConnected);
                              print("////////////////////////////////////////");

                              if (isConnected == ConnectivityResult.none) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'No internet connection',
                                      style:
                                      TextStyle(fontSize: 12, fontFamily: "pop"),
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
                              cubit.setSelectedCategory(null);
                              widget.onDone(null);
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
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }
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
                    child: Builder(
                        builder: (context) {
                          return ElevatedButton(
                            onPressed: () async {
                              final isConnected =
                              await Connectivity().checkConnectivity();

                              if (isConnected == ConnectivityResult.none) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'No internet connection',
                                      style:
                                      TextStyle(fontSize: 12, fontFamily: "pop"),
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
                              widget.onDone(state.selectedCategories);
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
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class SelectCategory extends StatelessWidget {
  final String category;
  final bool isSelected;
  final bool showClearIcon;
  final VoidCallback? onClear;

  const SelectCategory({
    super.key,
    required this.category,
    this.isSelected = false,
    this.showClearIcon = false,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: isSelected
                ? [
              Color(0xff9A1A00),

              //    Color(0xffE3AE94),
              Color(0xff9A1A00)
            ]
                : [Colors.transparent, Colors.transparent]),
        borderRadius: BorderRadius.circular(15),
        border: GradientBoxBorder(
          width: 2,
          gradient: LinearGradient(
            colors: isSelected
                ? [Colors.transparent, Colors.transparent]
                : [Color(0xffE3AE94), Color(0xffFF2B00)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            category,
            style: TextStyle(
              fontFamily: "pop",
              fontSize: 11.5,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          if (showClearIcon) ...[
            const SizedBox(width: 6),
            GestureDetector(
              onTap: onClear,
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ]
        ],
      ),
    );
  }
}