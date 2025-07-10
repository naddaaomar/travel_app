part of 'all_newest_cubit.dart';

@immutable
class AllNewestState {
  final bool isLoading;
  final bool hasError;
  final AllNewestModel? allTravelsModel;
  final bool scrolledToPage;

  const AllNewestState({
    this.isLoading = false,
    this.hasError = false,
    this.allTravelsModel,
    this.scrolledToPage = false,
  });

  AllNewestState copyWith({
    bool? isLoading,
    bool? hasError,
    AllNewestModel? allTravelsModel,
    bool? scrolledToPage,
  }) {
    return AllNewestState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      allTravelsModel: allTravelsModel ?? this.allTravelsModel,
      scrolledToPage: scrolledToPage ?? this.scrolledToPage,
    );
  }
}
