import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'package:p/screens/company_profile/data/models/CompanyDetailsModel.dart';
import 'package:p/screens/company_profile/data/models/NewestModel.dart';
import 'package:p/screens/company_profile/domain/use_cases/company_details_use_case.dart';

part 'company_details_state.dart';

@injectable
class CompanyDetailsCubit extends Cubit<CompanyDetailsState> {
  CompanyDetailsCubit(this.companyDetailsUseCase)
      : super(CompanyDetailsState());

  static CompanyDetailsCubit get(context) => BlocProvider.of(context);
  int currentPageNewest = 1;
  int currentPageDiscount = 1;
  int currentPageLeavingSoon = 1;
  int currentPageAllTravels = 1;
  final ScrollController scrollController = ScrollController();
  CompanyDetailsUseCase companyDetailsUseCase;

  @override
  void Close() {
    scrollController.dispose();
    super.close();
  }
  TravelTabType get currentTab => state.currentTab;

  void setCurrentTab(TravelTabType tab) {
    emit(state.copyWith(currentTab: tab));
  }

  void paginate({
    required TravelTabType tabType,
    required int pageIndex,
    required int pageSize,
    required String companyId
  }) {

    switch (tabType) {
      case TravelTabType.newest:
        getNewest(PageIndex: pageIndex, PageSize: pageSize, companyId: companyId);
        break;
      case TravelTabType.discount:
        getDiscount(PageIndex: pageIndex, PageSize: pageSize, companyId: companyId);
        break;
      case TravelTabType.leavingSoon:
        getLeavingSoon(PageIndex: pageIndex, PageSize: pageSize, companyId: companyId);
        break;
      case TravelTabType.allTravels:
        getTravels(PageIndex: pageIndex, PageSize: pageSize, companyId: companyId);
        break;
    }
    scrollToCurrentPage(currentPage: pageIndex);
  }

  void scrollToCurrentPage({required int currentPage }) {
    double buttonWidth = 55;
    double scrollOffset = (currentPage - 1) * (buttonWidth + 10);

    scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    emit(state.copyWith(scrolledToPage: true));
  }

  callData({required String companyId}) {
    getCompanyDetails(id: companyId);
    getTravels(PageSize: 4, PageIndex: 1, companyId: companyId);
    getDiscount(PageSize: 4, PageIndex: 1, companyId: companyId);
    getLeavingSoon(PageSize: 4, PageIndex: 1, companyId: companyId);
    getNewest(PageSize: 4, PageIndex: 1, companyId: companyId);
  }

  getCompanyDetails({required String id}) async {
    try {
      emit(state.copyWith(isLoadingDetails: true));
      var companyDetailsModel = await companyDetailsUseCase.callDetails(id: id);

      companyDetailsModel.fold(
            (l) {
          emit(state.copyWith(isLoadingDetails: false, hasErrorDetails: true));
        },
            (r) {
          emit(state.copyWith(
              hasErrorDetails: false,
              isLoadingDetails: false,
              companyDetailsModel: r));
        },
      );
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(isLoadingDetails: false, hasErrorDetails: true));
    }
  }

  getTravels(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) async {
    try {
      emit(state.copyWith(isLoadingTravels: true));
      var companyDetailsModel = await companyDetailsUseCase.callTravels(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);

      currentPageAllTravels = PageIndex;
      companyDetailsModel.fold(
            (l) {
          emit(state.copyWith(isLoadingTravels: false, hasErrorTravels: true));
        },
            (r) {
          emit(state.copyWith(
              hasErrorTravels: false,
              isLoadingTravels: false,
              allTravelsModel: r,
              currentPageAllTravels: PageIndex,
              totalPagesAllTravels: (r.totalPages)!.toInt()
          ));
        },
      );
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(isLoadingTravels: false, hasErrorTravels: true));
    }
  }

  getDiscount(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) async {
    try {
      emit(state.copyWith(isLoadingDiscount: true));
      var companyDetailsModel = await companyDetailsUseCase.callDiscount(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);

      currentPageDiscount = PageIndex;
      companyDetailsModel.fold(
            (l) {
          emit(
              state.copyWith(isLoadingDiscount: false, hasErrorDiscount: true));
        },
            (r) {
          emit(state.copyWith(
              hasErrorDiscount: false,
              isLoadingDiscount: false,
              allDiscountModel: r,
              currentPageDiscount: PageIndex,
              totalPagesDiscount: (r.totalPages)!.toInt()));
        },
      );
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(isLoadingDiscount: false, hasErrorDiscount: true));
    }
  }

  getLeavingSoon(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) async {
    try {
      emit(state.copyWith(isLoadingLeavingSoon: true));
      var companyDetailsModel = await companyDetailsUseCase.callLeavingSoon(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);
      currentPageLeavingSoon = PageIndex;

      companyDetailsModel.fold(
            (l) {
          emit(state.copyWith(
              isLoadingLeavingSoon: false, hasErrorLeavingSoon: true));
        },
            (r) {
          emit(state.copyWith(
              hasErrorLeavingSoon: false,
              isLoadingLeavingSoon: false,
              allLeavingSoonModel: r,
              currentPageLeavingSoon: PageIndex,
              totalPagesLeavingSoon: (r.totalPages)!.toInt()));
        },
      );
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(
          isLoadingLeavingSoon: false, hasErrorLeavingSoon: true));
    }
  }

  getNewest(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) async {
    try {
      emit(state.copyWith(isLoadingNewest: true));
      var companyDetailsModel = await companyDetailsUseCase.callNewest(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);
      currentPageNewest = PageIndex;
      companyDetailsModel.fold(
            (l) {
          emit(state.copyWith(isLoadingNewest: false, hasErrorNewest: true));
        },
            (r) {
          emit(state.copyWith(
              hasErrorNewest: false,
              isLoadingNewest: false,
              allNewestModel: r,
              currentPageNewest: PageIndex,
              totalPagesNewest: (r.totalPages)!.toInt()));
        },
      );
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(isLoadingNewest: false, hasErrorNewest: true));
    }
  }
}
enum TravelTabType { newest, discount, leavingSoon, allTravels }