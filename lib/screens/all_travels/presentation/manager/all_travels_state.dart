part of 'all_travels_cubit.dart';

@immutable
class AllTravelsState {
  final bool isLoading;
  final bool hasError;
  final AllTravelsModel? allTravelsModel;
  final bool scrolledToPage;

  const AllTravelsState({
    this.isLoading = false,
    this.hasError = false,
    this.allTravelsModel,
    this.scrolledToPage = false,
  });

  AllTravelsState copyWith({
    bool? isLoading,
    bool? hasError,
    AllTravelsModel? allTravelsModel,
    bool? scrolledToPage,
  }) {
    return AllTravelsState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      allTravelsModel: allTravelsModel ?? this.allTravelsModel,
      scrolledToPage: scrolledToPage ?? this.scrolledToPage,
    );
  }
}

