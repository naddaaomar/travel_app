part of 'company_details_cubit.dart';

@immutable
class CompanyDetailsState {
  final bool isLoadingDetails;
  final bool hasErrorDetails;
  final CompanyDetailsModel? companyDetailsModel;

  final bool isLoadingTravels;
  final bool hasErrorTravels;
  final AllTravelsModel? allTravelsModel;

  final bool isLoadingDiscount;
  final bool hasErrorDiscount;
  final AllTravelsModel? allDiscountModel;

  final bool isLoadingLeavingSoon;
  final bool hasErrorLeavingSoon;
  final AllTravelsModel? allLeavingSoonModel;

  final bool isLoadingNewest;
  final bool hasErrorNewest;
  final NewestModel? allNewestModel;

  final int currentPageNewest;
  final int currentPageDiscount;
  final int currentPageLeavingSoon;
  final int currentPageAllTravels;

  final int totalPagesNewest;
  final int totalPagesDiscount;
  final int totalPagesLeavingSoon;
  final int totalPagesAllTravels;

  final TravelTabType currentTab;
  final bool scrolledToPage;
  final bool scrolledDown;
  final bool isDescriptionExpanded;



  const CompanyDetailsState({
    this.isLoadingDetails = false,
    this.hasErrorDetails = false,
    this.companyDetailsModel,
    this.isLoadingTravels = false,
    this.hasErrorTravels = false,
    this.allTravelsModel,
    this.isLoadingDiscount = false,
    this.hasErrorDiscount = false,
    this.allDiscountModel,
    this.isLoadingLeavingSoon = false,
    this.hasErrorLeavingSoon = false,
    this.allLeavingSoonModel,
    this.isLoadingNewest = false,
    this.hasErrorNewest = false,
    this.allNewestModel,
    this.currentPageNewest = 1,
    this.currentPageDiscount = 1,
    this.currentPageLeavingSoon = 1,
    this.currentPageAllTravels = 1,
    this.totalPagesNewest = 1,
    this.totalPagesDiscount = 1,
    this.totalPagesLeavingSoon = 1,
    this.totalPagesAllTravels = 1,
    this.currentTab = TravelTabType.newest,
    this.scrolledToPage = false,
    this.scrolledDown = false,
    this.isDescriptionExpanded = false,


  });

  CompanyDetailsState copyWith({
    bool? isLoadingDetails,
    bool? hasErrorDetails,
    CompanyDetailsModel? companyDetailsModel,
    bool? isLoadingTravels,
    bool? hasErrorTravels,
    AllTravelsModel? allTravelsModel,
    bool? isLoadingDiscount,
    bool? hasErrorDiscount,
    AllTravelsModel? allDiscountModel,
    bool? isLoadingLeavingSoon,
    bool? hasErrorLeavingSoon,
    AllTravelsModel? allLeavingSoonModel,
    bool? isLoadingNewest,
    bool? hasErrorNewest,
    NewestModel? allNewestModel,
    int? currentPageNewest,
    int? currentPageDiscount,
    int? currentPageLeavingSoon,
    int? currentPageAllTravels,
    int? totalPagesNewest,
    int? totalPagesDiscount,
    int? totalPagesLeavingSoon,
    int? totalPagesAllTravels,
    TravelTabType? currentTab,
    bool? scrolledToPage,
    bool? scrolledDown,
    bool? isDescriptionExpanded,


  }) {
    return CompanyDetailsState(
      isLoadingDetails: isLoadingDetails ?? this.isLoadingDetails,
      hasErrorDetails: hasErrorDetails ?? this.hasErrorDetails,
      companyDetailsModel: companyDetailsModel ?? this.companyDetailsModel,
      isLoadingTravels: isLoadingTravels ?? this.isLoadingTravels,
      hasErrorTravels: hasErrorTravels ?? this.hasErrorTravels,
      allTravelsModel: allTravelsModel ?? this.allTravelsModel,
      isLoadingDiscount: isLoadingDiscount ?? this.isLoadingDiscount,
      hasErrorDiscount: hasErrorDiscount ?? this.hasErrorDiscount,
      allDiscountModel: allDiscountModel ?? this.allDiscountModel,
      isLoadingLeavingSoon: isLoadingLeavingSoon ?? this.isLoadingLeavingSoon,
      hasErrorLeavingSoon: hasErrorLeavingSoon ?? this.hasErrorLeavingSoon,
      allLeavingSoonModel: allLeavingSoonModel ?? this.allLeavingSoonModel,
      isLoadingNewest: isLoadingNewest ?? this.isLoadingNewest,
      hasErrorNewest: hasErrorNewest ?? this.hasErrorNewest,
      allNewestModel: allNewestModel ?? this.allNewestModel,
      currentPageNewest: currentPageNewest ?? this.currentPageNewest,
      currentPageDiscount: currentPageDiscount ?? this.currentPageDiscount,
      currentPageLeavingSoon:
          currentPageLeavingSoon ?? this.currentPageLeavingSoon,
      currentPageAllTravels:
          currentPageAllTravels ?? this.currentPageAllTravels,
      totalPagesNewest: totalPagesNewest ?? this.totalPagesNewest,
      totalPagesDiscount: totalPagesDiscount ?? this.totalPagesDiscount,
      totalPagesLeavingSoon:
          totalPagesLeavingSoon ?? this.totalPagesLeavingSoon,
      totalPagesAllTravels: totalPagesAllTravels ?? this.totalPagesAllTravels,
      currentTab: currentTab ?? this.currentTab,
      scrolledToPage: scrolledToPage ?? this.scrolledToPage,
      scrolledDown: scrolledDown ?? this.scrolledDown,
      isDescriptionExpanded: isDescriptionExpanded ?? this.isDescriptionExpanded,


    );
  }
}
