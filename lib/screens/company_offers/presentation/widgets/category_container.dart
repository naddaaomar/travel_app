import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:p/screens/company_offers/presentation/manager/travel_filter_cubit/travel_filter_cubit.dart';

class CategoryContainer extends StatefulWidget {
  const CategoryContainer({super.key, required this.onDone});

  final void Function(Set<String> category) onDone;


  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TravelFilterCubit, TravelFilterState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = TravelFilterCubit.get(context);
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 10),
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
              Row(
                children: [
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    "Category",
                    style: TextStyle(
                        fontFamily: "pop",
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                spacing: 0,
                runSpacing: 10,
                children: cubit.categories.map((cat) {
                  final bool isSelected = cubit.selectedCategories.contains(cat);
                  return GestureDetector(
                    onTap: () {
                      if (cat == "All") {
                        cubit.clearCategory();
                      } else {
                        cubit.toggleCategorySelection(cat);
                      }
                    },
                    child: SelectCategory(
                      category: cat,
                      isSelected: isSelected,
                      showClearIcon: isSelected && cat != "All",
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
                      onPressed: () {
                        cubit.clearCategory();
                        widget.onDone({"All"});
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
                      onPressed: () {
                        widget.onDone(cubit.selectedCategories);
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
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              )
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
              fontSize: 13,
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
