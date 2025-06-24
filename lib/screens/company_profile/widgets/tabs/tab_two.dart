import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/company_offers/presentation/manager/travel_filter_cubit/travel_filter_cubit.dart';
import 'package:p/screens/company_offers/presentation/widgets/travel_filtration.dart';
import 'package:p/screens/company_profile/widgets/custom_tab_bar.dart';
import 'package:p/screens/company_profile/widgets/tabs/trip_card.dart';

class TabTwo extends StatefulWidget {
  TabTwo({super.key, required this.card});

  Widget card;

  @override
  State<TabTwo> createState() => _TabTwoState();
}

class _TabTwoState extends State<TabTwo> {
  final int itemsPerPage = 15;
  int currentPage = 1;

  final ScrollController _scrollController = ScrollController();

  late List<Widget> items;

  @override
  void initState() {
    super.initState();
    items = List.generate(100, (index) => widget.card);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentPage() {
    double buttonWidth = 40;
    double scrollOffset = (currentPage - 1) * (buttonWidth + 15);

    _scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (items.length / itemsPerPage).ceil();
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    List<Widget> paginatedItems = items.sublist(
      startIndex,
      endIndex > items.length ? items.length : endIndex,
    );

    return BlocConsumer<TravelFilterCubit, TravelFilterState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit= TravelFilterCubit.get(context);
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),

              child: Column(
                children: [
                  SizedBox(height: 60),

                  // FadeInUp(
                  //     duration: Duration(milliseconds: 1000),
                  //     child: CustomTabBar()),

                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(
                            height: 10,
                          ),
                      itemCount: paginatedItems.length,
                      itemBuilder: (context, index) {
                        return FadeInUp(

                            duration: Duration(milliseconds: 1200),
                            child: paginatedItems[index]);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Keeps arrows at screen edges
                    children: [
                      IconButton(
                        icon: Icon(Icons.chevron_left),
                        onPressed: currentPage > 1
                            ? () {
                          setState(() {
                            currentPage--;
                            _scrollToCurrentPage();
                          });
                        }
                            : null,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(totalPages, (index) {
                              int pageNumber = index + 1;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            color: Color(0xffBD6F43), width: 2)),
                                    backgroundColor: currentPage == pageNumber
                                        ? Color(0xffBD6F43)
                                        : Colors.transparent,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      currentPage = pageNumber;
                                      _scrollToCurrentPage();
                                    });
                                  },
                                  child: Text(
                                    "$pageNumber",
                                    style: TextStyle(
                                      color: currentPage == pageNumber
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: currentPage < totalPages
                            ? () {
                          setState(() {
                            currentPage++;
                            _scrollToCurrentPage();
                          });
                        }
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

                final bool isCategoryDown = filterCubit.categoryDown;
                final bool isPriceDown = filterCubit.priceDown;
                return GestureDetector(
                  onTap: () {
                    filterCubit.closeAll();
                  },
                  child: Container(
                    color: Colors.black.withOpacity(.3),
                    width: (isCategoryDown || isPriceDown)
                        ? double.infinity
                        : 0,
                    height: (isCategoryDown || isPriceDown)
                        ? MediaQuery.of(context).size.height
                        : 0, // Set height to screen height
                  ),
                );
              },
            ),
            Positioned.fill(
              top: 7,
              left: 0,
              right: 0,
              child: FadeInUp(
                duration: Duration(milliseconds: 1150),
                child: TravelFiltration(


                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
