import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'package:p/screens/company_offers/domain/use_cases/company_discounts_use_case.dart';

part 'company_offers_state.dart';
@injectable
class CompanyOffersCubit extends Cubit<CompanyOffersState> {
  CompanyOffersCubit(this.companyDiscountsUseCase) : super(CompanyOffersState());
  CompanyDiscountsUseCase companyDiscountsUseCase;
  static CompanyOffersCubit get(context) => BlocProvider.of(context);
  final advancedDrawerController = AdvancedDrawerController();

  int currentPage = 1;
  final ScrollController scrollController = ScrollController();

  Future<void> getAllTravels({
    required int PageIndex,
    required int PageSize,
    String? Sort,
    double?MinPrice,
    double?MaxPrice,
    int? CategorieyId,required String companyId

  }) async {
    try {
      emit(state.copyWith(isLoading: true, hasError: false));
      final response = await companyDiscountsUseCase.callDiscount(
          PageIndex: PageIndex,
          PageSize: PageSize,
          Sort: Sort,
          MaxPrice: MaxPrice,
          MinPrice: MinPrice,
          companyId: companyId,
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




  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

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

// leftButton() {
//   currentPage--;
//   scrollToCurrentPage();
//   emit(LeftButton());
// }

// numClicked({required int page}) {
//   currentPage = page;
//   scrollToCurrentPage();
//   emit(NumberClicked());
// }

// rightButton() {
//   currentPage++;
//   scrollToCurrentPage();
//   emit(RightClicked());
// }
}