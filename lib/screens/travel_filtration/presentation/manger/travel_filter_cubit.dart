import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/travel_filtration/data/models/CategoryModel.dart';
import 'package:p/screens/travel_filtration/presentation/widgets/category_container.dart';
import 'package:p/screens/travel_filtration/presentation/widgets/price_container.dart';

import '../../domain/use_cases/travel_filter_use_case.dart';

part 'travel_filter_state.dart';

@injectable
class TravelFilterCubit extends Cubit<TravelFilterState> {
  TravelFilterCubit(this.travelFilterUseCase)
      : super(const TravelFilterState());
  static TravelFilterCubit get(context) => BlocProvider.of(context);
  TravelFilterUseCase travelFilterUseCase;
  void Function({
    int? category,
    RangeValues? priceRange,
    String? priceOrder,
  })? onFilterChanged;
  getCategories() async {
    try {
      emit(state.copyWith(isCategoriesLoading: true));
      var response = await travelFilterUseCase.call();
      response.fold(
        (l) {
          emit(state.copyWith(
              isCategoriesLoading: false, errorCategories: l.message));
          print(l.message.toString());
          print(l.message.toString());
          print(l.message.toString());
        },
        (r) {
          emit(state.copyWith(isCategoriesLoading: false, categoryModel: r));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          isCategoriesLoading: false, errorCategories: e.toString()));
      print(e.toString());
      print(e.toString());
      print(e.toString());
      print(e.toString());
    }
  }

  void toggleCategorySelectionById(int? categoryId) {
    emit(state.copyWith(
      selectedCategories: categoryId,
      hasSelectedCategories: true,
    ));
  }

  void clearCategory() {
    emit(state.copyWith(
      selectedCategories: null,
      hasSelectedCategories: true,
    ));
  }

  void closeAll() {
    emit(state.copyWith(
      categoryDown: false,
      priceDown: false,
      bottomContainer: null,
      overrideBottomContainer: true,
    ));
  }

  void setOnFilterChanged({
    required void Function({
      int? category,
      RangeValues? priceRange,
      String? priceOrder,
    }) onFilterChanged,
  }) {
    this.onFilterChanged = onFilterChanged;
  }

  void setSelectedCategory(int? id) {
    emit(state.copyWith(
      selectedCategories: id,
      hasSelectedCategories: true,
    ));
  }

  void toggleCategory() {
    final willOpen = !state.categoryDown;

    emit(state.copyWith(
      categoryDown: willOpen,
      priceDown: false,
      bottomContainer: willOpen
          ? CategoryContainer(
              onDone: (categories) {
                emit(state.copyWith(
                  selectedCategories: categories,
                  hasSelectedCategories: true,
                  categoryDown: false,
                  priceDown: false,
                  bottomContainer: null,
                  overrideBottomContainer: true,
                ));

                if (onFilterChanged != null) {
                  onFilterChanged!(
                    category: categories,
                    priceRange: state.selectedPriceRange,
                    priceOrder: state.selectedPriceOrder,
                  );
                }
              },
            )
          : null,
      overrideBottomContainer: true,
    ));
  }

  void togglePrice() {
    final willOpen = !state.priceDown;

    emit(state.copyWith(
      priceDown: willOpen,
      categoryDown: false,
      bottomContainer: willOpen
          ? PriceContainer(
              initialOrder: state.selectedPriceOrder,
              onDone: (range, order) {
                emit(state.copyWith(
                  selectedPriceRange: range,
                  selectedPriceOrder: order,
                  categoryDown: false,
                  priceDown: false,
                  bottomContainer: null,
                  overrideBottomContainer: true,
                ));

                if (onFilterChanged != null) {
                  onFilterChanged!(
                    category: state.selectedCategories,
                    priceRange: range,
                    priceOrder: order,
                  );
                }
              },
            )
          : null,
      overrideBottomContainer: true,
    ));
  }

  void changeRange(RangeValues values) {
    emit(state.copyWith(currentRangeValues: values));
  }

  void selectPriceOrder(String order) {
    emit(state.copyWith(selectedOrder: order));
  }

  void clearPrice() {
    emit(state.copyWith(
      selectedOrder: null,
      currentRangeValues: const RangeValues(700, 10000),
      selectedPriceRange: null,
    ));
  }
}
