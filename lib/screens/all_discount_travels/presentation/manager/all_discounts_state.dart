part of 'all_discounts_cubit.dart';

@immutable
class AllDiscountsState {
  final bool isLoading;
  final bool hasError;
  final AllDiscountModel? allTravelsModel;
  final bool scrolledToPage;

  const AllDiscountsState({
    this.isLoading = false,
    this.hasError = false,
    this.allTravelsModel,
    this.scrolledToPage = false,
  });

  AllDiscountsState copyWith({
    bool? isLoading,
    bool? hasError,
    AllDiscountModel? allTravelsModel,
    bool? scrolledToPage,
  }) {
    return AllDiscountsState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      allTravelsModel: allTravelsModel ?? this.allTravelsModel,
      scrolledToPage: scrolledToPage ?? this.scrolledToPage,
    );
  }
}
