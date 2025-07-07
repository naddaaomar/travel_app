import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/all_discount_travels/data/remote/models/AllDiscountModel.dart';
import 'package:p/screens/all_discount_travels/domain/use_cases/all_discunts_use_case.dart';
part 'all_discounts_state.dart';

@injectable
class AllDiscountsCubit extends Cubit<AllDiscountsState> {
  AllDiscountsCubit(this.allDiscountsUseCase) : super(const AllDiscountsState());

  final AllDiscountsUseCase allDiscountsUseCase;
  static AllDiscountsCubit get(context) => BlocProvider.of(context);

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

  Future<void> getAllDiscounts({
    required int PageIndex,
    required int PageSize,
    String? Sort,
    double?MinPrice,
    double?MaxPrice,
    int? CategorieyId

  }) async {
    try {
      emit(state.copyWith(isLoading: true, hasError: false));
      final response = await allDiscountsUseCase.call(
          PageIndex: PageIndex,
          PageSize: PageSize,
          Sort: Sort,
          MaxPrice: MaxPrice,
          MinPrice: MinPrice,
          CategorieyId: CategorieyId
      );

      currentPage = PageIndex;

      response.fold(
            (l) {
          print(l.toString());
          emit(state.copyWith(isLoading: false, hasError: true));
        },
            (r) {
          emit(state.copyWith(
            isLoading: false,
            hasError: false,
            allTravelsModel: r,
          ));
        },
      );
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
