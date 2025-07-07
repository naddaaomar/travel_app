import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/company_profile/data/models/NewestModel.dart';
import 'package:p/screens/company_profile/presentation/manager/company_details_cubit.dart';
import 'package:p/screens/company_profile/presentation/widgets/tabs/cards/newest_card.dart';
import 'package:p/screens/company_profile/presentation/widgets/travel_tabs.dart';

class TabTwo extends StatefulWidget {
  TabTwo({super.key, required this.companyId});

  final String companyId;

  @override
  State<TabTwo> createState() => _TabTwoState();
}

class _TabTwoState extends State<TabTwo> {
  @override
  void initState() {
    super.initState();
    CompanyDetailsCubit.get(context).setCurrentTab(TravelTabType.newest);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyDetailsCubit, CompanyDetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {



        final int currentPage = state.currentPageNewest;
        final int totalPages = state.totalPagesNewest;
        final List items = state.allNewestModel?.items ?? [];

        final TravelTabType tabType = TravelTabType.newest;
        var cubit = CompanyDetailsCubit.get(context);

        return TravelTabs(
          currentPage: currentPage,
          totalPages: totalPages,
          isLoading: state.isLoadingNewest,
          items: items,
          errorMessage: state.hasErrorNewest ? "No travels found for this company." : null,
          itemBuilder: (item, index) => NewestCard(newest: item),
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
