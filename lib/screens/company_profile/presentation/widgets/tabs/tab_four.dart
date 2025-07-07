import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/company_profile/presentation/manager/company_details_cubit.dart';
import 'package:p/screens/company_profile/presentation/widgets/tabs/cards/leaving_soon_card.dart';
import 'package:p/screens/company_profile/presentation/widgets/travel_tabs.dart';

class TabFour extends StatefulWidget {
  TabFour({super.key, required this.companyId});

  final String companyId;

  @override
  State<TabFour> createState() => _TabFourState();
}

class _TabFourState extends State<TabFour> {
  @override
  void initState() {
    super.initState();
    CompanyDetailsCubit.get(context).setCurrentTab(TravelTabType.leavingSoon);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyDetailsCubit, CompanyDetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final int currentPage = state.currentPageLeavingSoon;
        final int totalPages = state.totalPagesLeavingSoon;
        final List items = state.allLeavingSoonModel?.items ?? [];

        final TravelTabType tabType = TravelTabType.leavingSoon;
        var cubit = CompanyDetailsCubit.get(context);
        return TravelTabs(
          currentPage: currentPage,
          totalPages: totalPages,
          items: items,
          isLoading: state.isLoadingLeavingSoon,

          errorMessage: state.hasErrorLeavingSoon ? "No travels found for this company." : null,
          itemBuilder: (item, index) => LeavingSoonCard(items: item),
          onNext: () => cubit.paginate(
            tabType: tabType,
            companyId: widget.companyId,
            pageIndex: currentPage + 1,
            pageSize: 4,
          ),
          onPrevious: () => cubit.paginate(
            tabType: tabType,
            pageIndex: currentPage - 1,
            pageSize: 4,
            companyId: widget.companyId,
          ),
          onPageTapped: (page) => cubit.paginate(
            tabType: tabType,
            pageIndex: page,
            companyId: widget.companyId,
            pageSize: 4,
          ),
        );
      },
    );
  }
}
