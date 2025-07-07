import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/company_profile/presentation/manager/company_details_cubit.dart';
import 'package:p/screens/company_profile/presentation/widgets/travel_tabs.dart';
import 'package:p/screens/company_profile/presentation/widgets/tabs/cards/discount_card.dart';

class TabThree extends StatefulWidget {
  const TabThree({super.key, required this.companyId});

  final String companyId;

  @override
  State<TabThree> createState() => _TabThreeState();
}

class _TabThreeState extends State<TabThree> {
  @override
  void initState() {
    super.initState();
    CompanyDetailsCubit.get(context).setCurrentTab(TravelTabType.discount);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyDetailsCubit, CompanyDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = CompanyDetailsCubit.get(context);

        final int currentPage = state.currentPageDiscount;
        final int totalPages = state.totalPagesDiscount;
        final List items = state.allDiscountModel?.items ?? [];

        final TravelTabType tabType = TravelTabType.discount;

        return TravelTabs(
          currentPage: currentPage,
          totalPages: totalPages,
          items: items,
          isLoading: state.isLoadingDetails,
          errorMessage: state.hasErrorDiscount
              ? "No travels found for this company."
              : null,
          itemBuilder: (item, index) => DiscountCard(items: item),
          onNext: () => cubit.paginate(
            tabType: tabType,
            companyId: widget.companyId,
            pageIndex: currentPage + 1,
            pageSize: 4,
          ),
          onPrevious: () => cubit.paginate(
            tabType: tabType,
            companyId: widget.companyId,
            pageIndex: currentPage - 1,
            pageSize: 4,
          ),
          onPageTapped: (page) => cubit.paginate(
            tabType: tabType,
            companyId: widget.companyId,
            pageIndex: page,
            pageSize: 4,
          ),
        );
      },
    );
  }
}
