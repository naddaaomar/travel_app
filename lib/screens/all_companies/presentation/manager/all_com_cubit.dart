import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:p/screens/all_companies/presentation/widgets/rating_companies/widgets/rating_container.dart';
import '../../data/models/AllCompaniesModel.dart';
import '../../domain/use_cases/all_companies_use_case.dart';

part 'all_com_state.dart';

@injectable
class AllComCubit extends Cubit<AllComState> {
  AllComCubit({required this.allCompaniesUseCase}) : super(AllComState());

  AllCompaniesUseCase allCompaniesUseCase;
  static AllComCubit get(context) => BlocProvider.of(context);

  final ScrollController scrollController = ScrollController();
  int currentPage = 1;

  void scrollToCurrentPage() {
    double buttonWidth = 20;
    double scrollOffset = (currentPage - 1) * (buttonWidth + 10);

    scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    emit(state.copyWith(scrolledToPage: true));
  }

  Future<void> getCom(
      {required int PageIndex,
        required int PageSize,
        String? sort,
        int? rate}) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final response = await allCompaniesUseCase.call(
          PageIndex: PageIndex, PageSize: PageSize, rate: rate, sort: sort);
      currentPage = PageIndex;

      response.fold(
            (l) {
          emit(state.copyWith(isLoading: false, error: l.message));
        },
            (r) {
          emit(state.copyWith(
            isLoading: false,
            allCompanies: r,
            currentPage: PageIndex,
            totalPages: r.totalPages?.toInt(),
            error: null,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
  void closeAll() {
    emit(state.copyWith(
      ratingDown: false,
      bottomContainer: null,
      overrideBottomContainer: true,
    ));
  }
  void setOnFilterChanged({
    required void Function({
    int? rate,
    String? rateingOrder,
    }) onFilterChanged,
  }) {
    this.onFilterChanged = onFilterChanged;
  }
  void Function({
  int? rate,
  String? rateingOrder,
  })? onFilterChanged;

  selectRating(int rating){
    emit(state.copyWith(selectedRating: rating,
        hasSelectedRating: true));

  }

  void selectRatingOrder(String order) {
    emit(state.copyWith(selectedRatingOrder: order));
  }
  void clearRating() {
    emit(state.copyWith(selectedRatingOrder: "Descending",
      selectedRating: null,
      bottomContainer: null,
      overrideBottomContainer: true,
      hasSelectedRating: true,
      ratingDown: false,));
  }
  void toggleRating() {
    final willOpen = !state.ratingDown;

    emit(state.copyWith(
      ratingDown: willOpen,
      bottomContainer: willOpen
          ? RatingContainer(
        onDone: (rate, sort) {
          emit(state.copyWith(
            selectedRating: rate,
            ratingDown: false,
            selectedRatingOrder: sort,
            bottomContainer: null,
            overrideBottomContainer: true,
          ));

          if (onFilterChanged != null) {
            onFilterChanged!(
              rate: rate,
              rateingOrder: state.selectedRatingOrder,
            );
          }
        },
      )
          : null,
      overrideBottomContainer: true,
    ));
  }
}