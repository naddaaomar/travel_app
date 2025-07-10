import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/company_profile/presentation/manager/company_details_cubit.dart';
import 'package:p/screens/travel_filtration/presentation/manger/travel_filter_cubit.dart';
import 'package:p/screens/travel_filtration/presentation/pages/travel_filtration.dart';
import 'package:shimmer/shimmer.dart';

class TravelTabs extends StatefulWidget {
  TravelTabs({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.totalPages,
    required this.currentPage,
    required this.onNext,
    required this.onPageTapped,
    required this.onPrevious,
    this.errorMessage,
    required this.isLoading
  });
  final String? errorMessage;
  bool isLoading;
  final int currentPage;

  final int totalPages;

  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final Function(int) onPageTapped;
  final List items;
  final Widget Function(dynamic item, int index) itemBuilder;

  @override
  State<TravelTabs> createState() => _TravelTabsState();
}

class _TravelTabsState extends State<TravelTabs> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyDetailsCubit, CompanyDetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, companyState) {
        var companyCubit = CompanyDetailsCubit.get(context);
        return BlocConsumer<TravelFilterCubit, TravelFilterState>(
          listener: (context, filterState) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            if (widget.errorMessage != null) {
                              return Center(
                                child: FadeIn(
                                  duration: Duration(milliseconds: 1000),
                                  child: Text(
                                    widget.errorMessage!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "pop",
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }
                            else if(widget.isLoading){
                              return ListView.builder(
                                padding: EdgeInsets.symmetric(vertical: 0),
                                itemCount: 6,
                                itemBuilder: (context, index) =>
                                    Shimmer.fromColors(
                                      baseColor: Color(0xffD8D1CA),
                                      highlightColor: Color(0xffCBC0B6),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 10),
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                              );
                            }

                            else if (widget.items.isEmpty) {
                              return Center(
                                child: FadeIn(
                                  duration: Duration(milliseconds: 1000),
                                  child: Text(
                                    "No travels found.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "pop",
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return  ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(height: 10),
                                itemCount: widget.items.length,
                                itemBuilder: (context, index) {
                                  return FadeInUp(
                                    duration: Duration(milliseconds: 1200),
                                    child: widget.itemBuilder(widget.items[index], index),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Keeps arrows at screen edges
                        children: [
                          IconButton(
                              icon: Icon(Icons.chevron_left),
                              onPressed: widget.currentPage > 1
                                  ? widget.onPrevious
                                  : null),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: companyCubit.scrollController,
                              scrollDirection: Axis.horizontal,
                              child: Row(

                                mainAxisSize: MainAxisSize.min,
                                children: widget.errorMessage == null?
                                List.generate(widget.totalPages, (index) {
                                  int pageNumber = index + 1;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          alignment: Alignment.center,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              side: BorderSide(
                                                  color: Color(0xffBD6F43),
                                                  width: 2)),
                                          backgroundColor:
                                          widget.currentPage == pageNumber
                                              ? Color(0xffBD6F43)
                                              : Colors.transparent,
                                        ),
                                        onPressed: () =>
                                            widget.onPageTapped(pageNumber),
                                        child: Text(
                                          "$pageNumber",
                                          style: TextStyle(
                                            color:
                                            widget.currentPage == pageNumber
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }):[SizedBox.shrink()],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.chevron_right),
                            onPressed: widget.currentPage < widget.totalPages
                                ? widget.onNext
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                BlocBuilder<TravelFilterCubit, TravelFilterState>(
                  builder: (context, state) {
                    final filterCubit = context.read<TravelFilterCubit>();
                    final bool isCategoryDown = state.categoryDown;
                    final bool isPriceDown = state.priceDown;

                    final bool isOverlayVisible = isCategoryDown || isPriceDown;

                    return isOverlayVisible
                        ? Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          filterCubit.closeAll();
                        },
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    )
                        : SizedBox.shrink();
                  },
                ),
                widget.errorMessage == null?
                Positioned.fill(
                  top: 7,
                  left: 0,
                  right: 0,
                  child: FadeInUp(
                    duration: Duration(milliseconds: 1150),
                    child: TravelFiltration(),
                  ),
                ):SizedBox.shrink()
                ,
              ],
            );
          },
        );
      },
    );
  }
}