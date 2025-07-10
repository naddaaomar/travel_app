part of 'company_offers_cubit.dart';

@immutable
class CompanyOffersState {
  final bool isLoading;
  final bool hasError;
  final AllTravelsModel? allTravelsModel;
  final bool scrolledToPage;

  const CompanyOffersState({
    this.isLoading = false,
    this.hasError = false,
    this.allTravelsModel,
    this.scrolledToPage = false,
  });

  CompanyOffersState copyWith({
    bool? isLoading,
    bool? hasError,
    AllTravelsModel? allTravelsModel,
    bool? scrolledToPage,
  }) {
    return CompanyOffersState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      allTravelsModel: allTravelsModel ?? this.allTravelsModel,
      scrolledToPage: scrolledToPage ?? this.scrolledToPage,
    );
  }
}