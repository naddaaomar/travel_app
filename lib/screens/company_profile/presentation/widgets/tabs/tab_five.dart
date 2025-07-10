import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/ai/Ai_requests.dart';
import 'package:p/screens/company_profile/presentation/manager/company_details_cubit.dart';
import 'package:p/screens/company_profile/presentation/widgets/tabs/cards/all_travels_card.dart';
import 'package:p/screens/company_profile/presentation/widgets/travel_tabs.dart';
import 'package:p/screens/trip_details/views/trip_details_view_body.dart';

class TabFive extends StatefulWidget {
  TabFive({super.key, required this.companyId});

  final String companyId;

  @override
  State<TabFive> createState() => _TabFiveState();
}

class _TabFiveState extends State<TabFive> {
  @override
  void initState() {
    super.initState();
    CompanyDetailsCubit.get(context).setCurrentTab(TravelTabType.allTravels);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyDetailsCubit, CompanyDetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final int currentPage = state.currentPageAllTravels;
        final int totalPages = state.totalPagesAllTravels;
        final List items = state.allTravelsModel?.items ?? [];

        final TravelTabType tabType = TravelTabType.allTravels;
        var cubit = CompanyDetailsCubit.get(context);
        return TravelTabs(
          currentPage: currentPage,
          totalPages: totalPages,
          items: items,
          isLoading: state.isLoadingTravels,
          errorMessage: state.hasErrorTravels
              ? "No travels found for this company."
              : null,
          itemBuilder: (item, index) => GestureDetector(
              onTap: () async{
                final aiRequests = AiRequests();

                await aiRequests.trackInteractionClick(
                  contentId:item.id.toString(),
                  type: 'travel',
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TripDetailsViewBody(id: item.id.toString()),
                    ));
              },
              child: TravelCard(items: item)),
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
