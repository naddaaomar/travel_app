part of 'all_com_cubit.dart';

class AllComState {
  final bool isLoading;
  final AllCompaniesModel? allCompanies;
  final String? error;
  final int currentPage;
  final int? totalPages;
  final bool ratingDown;
  final Widget? bottomContainer;
  final String? selectedRatingOrder;
  final int? selectedRating;
  final bool scrolledToPage;


  AllComState(
      {this.isLoading = false,
        this.allCompanies,
        this.error,
        this.currentPage = 1,
        this.totalPages,
        this.ratingDown = false,
        this.bottomContainer,
        this.selectedRatingOrder = "Descending",
        this.selectedRating,
        this.scrolledToPage = false,
      });

  AllComState copyWith(
      {bool? isLoading,
        AllCompaniesModel? allCompanies,
        String? error,
        int? currentPage,
        int? totalPages,
        bool? ratingDown,
        bool hasSelectedRating = false,
        Widget? bottomContainer,
        bool overrideBottomContainer = false,
        String? selectedRatingOrder,
        int? selectedRating,
        bool? scrolledToPage,
      }) {
    return AllComState(
      isLoading: isLoading ?? this.isLoading,
      allCompanies: allCompanies ?? this.allCompanies,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      ratingDown: ratingDown ?? this.ratingDown,
      bottomContainer: overrideBottomContainer
          ? bottomContainer
          : (bottomContainer ?? this.bottomContainer),
      selectedRatingOrder: selectedRatingOrder ?? this.selectedRatingOrder,
      selectedRating: hasSelectedRating?selectedRating:this.selectedRating,
      scrolledToPage: scrolledToPage ?? this.scrolledToPage,
    );
  }
}