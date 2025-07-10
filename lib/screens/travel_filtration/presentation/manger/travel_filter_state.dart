part of 'travel_filter_cubit.dart';

@immutable
class TravelFilterState {
  final bool categoryDown;
  final bool priceDown;
  final Widget? bottomContainer;
  final int? selectedCategories;
  final RangeValues currentRangeValues;
  final RangeValues? selectedPriceRange;
  final String? selectedPriceOrder;
  final String selectedOrder;
  final bool? isCategoriesLoading;
  final List<CategoryModel>? categoryModel;
  final String? errorCategories;

  const TravelFilterState({
    this.categoryDown = false,
    this.priceDown = false,
    this.bottomContainer,
    this.selectedCategories = null,
    this.currentRangeValues = const RangeValues(1000, 4000),
    this.selectedPriceRange,
    this.selectedPriceOrder,
    this.selectedOrder = "Descending",
    this.categoryModel,
    this.isCategoriesLoading = false,
    this.errorCategories,
  });

  TravelFilterState copyWith(
      {bool? categoryDown,
        bool? priceDown,
        Widget? bottomContainer,
        bool overrideBottomContainer = false,
        int? selectedCategories,
        bool hasSelectedCategories = false,
        RangeValues? currentRangeValues,
        RangeValues? selectedPriceRange,
        String? selectedPriceOrder,
        String? selectedOrder,
        bool? isCategoriesLoading,
        List<CategoryModel>? categoryModel,
        bool isAll = true,
        String? errorCategories}) {
    return TravelFilterState(
        categoryDown: categoryDown ?? this.categoryDown,
        priceDown: priceDown ?? this.priceDown,
        bottomContainer: overrideBottomContainer
            ? bottomContainer
            : (bottomContainer ?? this.bottomContainer),
        selectedCategories: hasSelectedCategories
            ? selectedCategories
            : this.selectedCategories,
        currentRangeValues: currentRangeValues ?? this.currentRangeValues,
        selectedPriceRange: selectedPriceRange ?? this.selectedPriceRange,
        selectedPriceOrder: selectedPriceOrder ?? this.selectedPriceOrder,
        selectedOrder: selectedOrder ?? this.selectedOrder,
        categoryModel: categoryModel ?? this.categoryModel,
        isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
        errorCategories: errorCategories ?? this.errorCategories);
  }
}