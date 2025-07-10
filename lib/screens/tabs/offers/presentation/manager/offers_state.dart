part of 'offers_cubit.dart';

@immutable
class OffersState {
  final bool isLoadingCompanies;
  final bool isLoadingDiscounts;
  final AllCompaniesModel? companies;
  final DiscountTravelsModel? discounts;
  final String? error;
  final String? selectedRatingOrder;
  final int? selectedRating;

  const OffersState({
    this.isLoadingCompanies = false,
    this.isLoadingDiscounts = false,
    this.companies,
    this.discounts,
    this.error,
    this.selectedRatingOrder="Descending",
    this.selectedRating
  });

  OffersState copyWith({
    bool? isLoadingCompanies,
    bool? isLoadingDiscounts,
    AllCompaniesModel? companies,
    DiscountTravelsModel? discounts,
    String? error,
    bool hasSelectedRating = false,
    String? selectedRatingOrder,
    int? selectedRating
  }) {
    return OffersState(
        isLoadingCompanies: isLoadingCompanies ?? this.isLoadingCompanies,
        isLoadingDiscounts: isLoadingDiscounts ?? this.isLoadingDiscounts,
        companies: companies ?? this.companies,
        discounts: discounts ?? this.discounts,
        error: error ?? this.error,
        selectedRatingOrder: selectedRatingOrder ?? this.selectedRatingOrder,
        selectedRating: hasSelectedRating?selectedRating:this.selectedRating
    );
  }
}