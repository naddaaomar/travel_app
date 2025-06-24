import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/company_offers/presentation/widgets/category_container.dart';
import 'package:p/screens/company_offers/presentation/widgets/price_container.dart';

part 'travel_filter_state.dart';

class TravelFilterCubit extends Cubit<TravelFilterState> {
  TravelFilterCubit() : super(TravelFilterInitial());
  static TravelFilterCubit get(context) => BlocProvider.of(context);
  bool categoryDown = false;
  bool priceDown = false;

  Widget? bottomContainer;
  Set<String> selectedCategories = {"All"};

  final List<String> categories = [
    "All",
    "Beach",
    "Religious",
    "Safari",
    "Urban",
    "Cultural",
    "Nile Cruises"
  ];
  void toggleCategorySelection(String category) {
    if (category == "All") {
      selectedCategories = {"All"};
    } else {
      selectedCategories.remove("All");
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }

      // If all categories removed, reset to "All"
      if (selectedCategories.isEmpty) {
        selectedCategories.add("All");
      }
    }

    emit(SelectCategory());
  }

  void clearCategory() {
    selectedCategories = {"All"};
    emit(ClearCategory());
  }

  void closeAll() {
    categoryDown = false;
    priceDown = false;
    bottomContainer = null;
    emit(CloseAllDropDown());
  }

  Set<String> selectedCategoryItems = {"All"};
  RangeValues? selectedPriceRange;

  String? selectedPriceOrder;
  String? selectedOrder = "Descending";
  RangeValues currentRangeValues = RangeValues(500, 1500);
  double minPrice = 300;
  double maxPrice = 3000;

  changeRange({required RangeValues values}) {
    currentRangeValues = values;

    emit(ChangePriceRange());
  }

  selectPriceOrder({required String order}) {
    selectedOrder = order;
    emit(SelectPriceOrder());
  }
  clearPrice(){
    selectedOrder="Descending";
    currentRangeValues = RangeValues(500, 1500);
    selectedPriceRange=null;
    emit(ClearPrice());
  }

  void toggleCategory({Function? onFilterChanged}) {
    final willOpen = !categoryDown;
    categoryDown = willOpen;
    priceDown = false;

    bottomContainer = willOpen
        ? CategoryContainer(
      onDone: (categories) {
        selectedCategoryItems = categories.toSet();
        if (onFilterChanged != null) {
          onFilterChanged(
            categories: selectedCategoryItems,
            priceRange: selectedPriceRange,
            priceOrder: selectedPriceOrder,
          );
        }
        closeAll();
      },
    )
        : null;

    emit(ToggleCategory());
  }

  void togglePrice({ onFilterChanged}) {
    final willOpen = !priceDown;
    priceDown = willOpen;
    categoryDown = false;
    bottomContainer = willOpen
        ? PriceContainer(
            initialOrder: selectedPriceOrder,
            onDone: (range, order) {
              selectedPriceRange = range??currentRangeValues;
              selectedPriceOrder = order;
              if (onFilterChanged != null){ onFilterChanged(
                categories: selectedCategoryItems,
                priceRange: selectedPriceRange,
                priceOrder: selectedPriceOrder,
              );}

              closeAll();
            },
          )
        : null;

    emit(TogglePrice());
  }

}
