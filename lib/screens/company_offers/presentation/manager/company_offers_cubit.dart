import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/company_offers/data/models/company_offers_model.dart';

part 'company_offers_state.dart';

class CompanyOffersCubit extends Cubit<CompanyOffersState> {
  CompanyOffersCubit() : super(CompanyOffersInitial());

  static CompanyOffersCubit get(context) => BlocProvider.of(context);
  final advancedDrawerController = AdvancedDrawerController();

  int currentPage = 1;
  final int itemsPerPage = 5;
  final int totalItems = companyOffersModel.length;
  List<int> pages = [];
  final ScrollController scrollController = ScrollController();
  List<CompanyOffersModel> filteredOffers = [];
  Set<String>? selectedCategory;
  RangeValues? selectedPriceRange;
  String? selectedPriceOrder;
  void applyFilters({
    Set<String>? categories,
    RangeValues? priceRange,
    String? priceOrder,
  }) {
    // Use new values if provided, else fallback to existing
    selectedCategory = categories ?? selectedCategory;
    selectedPriceRange = priceRange ?? selectedPriceRange;
    selectedPriceOrder = priceOrder ?? selectedPriceOrder;

    filteredOffers = companyOffersModel.where((offer) {
      bool matchesCategory = selectedCategory == null ||
          selectedCategory!.contains("All") ||
          selectedCategory!.contains(offer.category);


      bool matchesPrice = selectedPriceRange == null ||
          (offer.newPrice >= selectedPriceRange!.start &&
              offer.newPrice <= selectedPriceRange!.end);

      return matchesCategory && matchesPrice;
    }).toList();

    // Sorting
    if (selectedPriceOrder == "Descending") {
      filteredOffers.sort((a, b) => b.newPrice.compareTo(a.newPrice));
      emit(PriceDescending());
    } else {
      filteredOffers.sort((a, b) => a.newPrice.compareTo(b.newPrice));
      emit(PriceAscending());
    }

    // Reset pagination
    currentPage = 1;
    int totalPages = (filteredOffers.length + itemsPerPage - 1) ~/ itemsPerPage;
    pages = List.generate(totalPages, (index) => index + 1);

    emit(PageNumber());
  }



  init() {
    filteredOffers = companyOffersModel;
    filteredOffers
        .sort((a, b) => b.newPrice.compareTo(a.newPrice)); // initial full list
    int totalPages = (filteredOffers.length + itemsPerPage - 1) ~/ itemsPerPage;
    pages = List.generate(totalPages, (index) => index + 1);
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
    emit(CurrentPageScroll());
  }

  leftButton() {
    currentPage--;
    scrollToCurrentPage();
    emit(LeftButton());
  }

  numClicked({required int page}) {
    currentPage = page;
    scrollToCurrentPage();
    emit(NumberClicked());
  }

  rightButton() {
    currentPage++;
    scrollToCurrentPage();
    emit(RightClicked());
  }
}
