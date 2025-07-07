import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/tabs/offers/data/models/DiscountTravelsModel.dart';

import '../../../../all_companies/data/models/AllCompaniesModel.dart';
import '../../domain/use_cases/offers_use_case.dart';

part 'offers_state.dart';

@injectable
class OffersCubit extends Cubit<OffersState> {
  OffersCubit({required this.offersUseCase}) : super(const OffersState()) {
    scrollController.addListener(_onScroll);
  }

  final OffersUseCase offersUseCase;
  final ScrollController scrollController = ScrollController();
  final CardSwiperController controller = CardSwiperController();

  static OffersCubit get(context) => BlocProvider.of(context);

  int currentPage = 1;
  int totalPages = 1;
  final List<Items> allItems = [];

  bool isFetchingMore = false;
  Timer? autoPlayTimer;
  bool swipeRight = true;

  Future<void> intiFun(
      {required int PageIndexdis,
      required int PageSizedis,
      required int PageSizecom,
      String? sort,
      int? rate}) async {
    await initPagination(pageSize: PageSizecom, sort: sort, rate: rate);
    await getDiscount(PageIndex: PageIndexdis, PageSize: PageSizedis);
  }

  Future<void> getDiscount({
    required int PageIndex,
    required int PageSize,
  }) async {
    emit(state.copyWith(isLoadingDiscounts: true));
    try {
      final response = await offersUseCase.callDiscount(
        PageIndex: PageIndex,
        PageSize: PageSize,
      );
      response.fold(
        (l) {
          emit(state.copyWith(isLoadingDiscounts: false, error: l.message));
        },
        (r) {
          emit(state.copyWith(
            isLoadingDiscounts: false,
            discounts: r,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoadingDiscounts: false, error: e.toString()));
    }
  }

  Future<void> getCom({
    required int PageIndex,
    required int PageSize,
    String? sort,
    int? rate,
    bool loadMore = false,
  }) async {
    if (isFetchingMore) return;

    isFetchingMore = true;
    if (!loadMore) emit(state.copyWith(isLoadingCompanies: true));

    try {
      final response = await offersUseCase.callCompanies(
        rate: rate,
        sort: sort,
        PageIndex: PageIndex,
        PageSize: PageSize,
      );

      response.fold((failure) {
        emit(state.copyWith(isLoadingCompanies: false, error: failure.message));
      }, (result) {
        currentPage = PageIndex;
        totalPages = ((result.totalPages)!.toInt() ?? 1);

        final List<Items> newItems = result.items ?? [];

        if (loadMore) {
          allItems.addAll(newItems);
        } else {
          allItems
            ..clear()
            ..addAll(newItems);
        }

        final updatedResult = result.copyWith(items: allItems);
        emit(state.copyWith(
          isLoadingCompanies: false,
          companies: updatedResult,
        ));
      });
    } catch (e) {
      emit(state.copyWith(isLoadingCompanies: false, error: e.toString()));
    } finally {
      isFetchingMore = false;
    }
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (!isFetchingMore && currentPage < totalPages) {
        getCom(PageIndex: currentPage + 1, PageSize: 10, loadMore: true);
      }
    }
  }

  Future<void> initPagination(
      {int pageSize = 10, String? sort, int? rate}) async {
    await getCom(
        PageIndex: 1,
        PageSize: pageSize,
        loadMore: false,
        rate: rate,
        sort: sort);
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

  selectRating(int rating) {
    emit(state.copyWith(selectedRating: rating, hasSelectedRating: true));
  }

  void selectRatingOrder(String order) {
    emit(state.copyWith(selectedRatingOrder: order));
  }

  void clearRating() {
    emit(state.copyWith(
      selectedRatingOrder: "Descending",
      selectedRating: null,
      hasSelectedRating: true,
    ));

  }
  onDone({int? rate, String? sort}) {
    emit(state.copyWith(
      selectedRating: rate,
      selectedRatingOrder: sort,
    ));
    if (onFilterChanged != null) {
      onFilterChanged!(
        rate: rate,
        rateingOrder: state.selectedRatingOrder,
      );
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    autoPlayTimer?.cancel();
    return super.close();
  }
}
