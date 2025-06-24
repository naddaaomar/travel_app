import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/all_companies/models/AllCompanies.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';
import 'package:p/screens/tabs/offers/data/models/company_offers_model.dart';
import 'package:p/screens/tabs/offers/presentation/pages/offers_screen.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/companies.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/company_card.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/offer_card.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/travel_filtration.dart';
import 'package:p/screens/trip_details/views/trip_details_view_body.dart';

import '../../../../trip_details/views/discount_trip_details/views/discount_trip_details.dart';

class CompanyOffers extends StatefulWidget {
  CompanyOffers({super.key, required this.item});

  Items item;

  @override
  State<CompanyOffers> createState() => _CompanyOffersState();
}

class _CompanyOffersState extends State<CompanyOffers> {
  final _advancedDrawerController = AdvancedDrawerController();

  int currentPage = 1;
  final int itemsPerPage = 5;
  final int totalItems = companyOffersModel.length;
  List<int> pages = [];
  final ScrollController _scrollController = ScrollController();
  List<CompanyOffersModel> filteredOffers = [];
  String? selectedCategory;
  RangeValues? selectedPriceRange;

  void applyFilters(
      {String? category, RangeValues? priceRange, String? priceOrder}) {
    setState(() {
      selectedCategory = category;
      selectedPriceRange = priceRange;

      filteredOffers = companyOffersModel.where((offer) {
        bool matchesCategory = category == null || offer.category == category;
        bool matchesPrice = priceRange == null ||
            (offer.newPrice >= priceRange.start &&
                offer.newPrice <= priceRange.end);
        return matchesCategory && matchesPrice;
      }).toList();

      if (priceOrder == "Descending") {
        filteredOffers.sort((a, b) => b.newPrice.compareTo(a.newPrice));
      } else {
        filteredOffers.sort((a, b) => a.newPrice.compareTo(b.newPrice));
      }
      // Reset pagination
      currentPage = 1;
      int totalPages =
          (filteredOffers.length + itemsPerPage - 1) ~/ itemsPerPage;
      pages = List.generate(totalPages, (index) => index + 1);
    });
  }

  @override
  void initState() {
    super.initState();
    filteredOffers = companyOffersModel;
    filteredOffers
        .sort((a, b) => b.newPrice.compareTo(a.newPrice)); // initial full list
    int totalPages = (filteredOffers.length + itemsPerPage - 1) ~/ itemsPerPage;
    pages = List.generate(totalPages, (index) => index + 1);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentPage() {
    double buttonWidth = 20;
    double scrollOffset = (currentPage - 1) * (buttonWidth + 10);

    _scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = pages.length;
    return WillPopScope(
      onWillPop: () async {
        if (_advancedDrawerController.value.visible) {
          _advancedDrawerController.hideDrawer();
          return false;
        }
        return true;
      },
      child: AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              tileMode: TileMode.repeated,
              colors: ColorApp.drawerColors,
            ),
          ),
        ),
        openScale: .9,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: true,
        openRatio: .5,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: NewDrawer(
          controller: _advancedDrawerController,
        ),
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                          IconButton(
                            onPressed: () {
                              _advancedDrawerController.showDrawer();
                            },
                            icon: ValueListenableBuilder<AdvancedDrawerValue>(
                              valueListenable: _advancedDrawerController,
                              builder: (_, value, __) {
                                return AnimatedSwitcher(
                                  duration: Duration(milliseconds: 250),
                                  child: value.visible
                                      ? Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.black,
                                          ),
                                        )
                                      : Icon(
                                          Icons.menu,
                                          color: Colors.black.withOpacity(.8),
                                          key: ValueKey<bool>(value.visible),
                                        ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    CompanyCard(
                      id: widget.item.id.toString()??"",
                      img: widget.item.profileImageUrl??"",
                      companyName: widget.item.companyName??"",

                    ),
                    Positioned.fill(
                      top: 235,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 0),
                        child: Column(
                          children: [
                            LiveList(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 15),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              showItemInterval: Duration(milliseconds: 150),
                              showItemDuration: Duration(milliseconds: 350),
                              reAnimateOnVisibility: false,
                              scrollDirection: Axis.vertical,
                              itemBuilder: animationItemBuilder(
                                (index) {
                                  // Pagination logic: Adjust the index based on currentPage and itemsPerPage
                                  int startIndex =
                                      (currentPage - 1) * itemsPerPage;
                                  int itemIndex = startIndex + index;

                                  if (itemIndex < companyOffersModel.length) {
                                    return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DiscountTripDetails(
                                                image:
                                                    "assets/images/onboard3.png",
                                                    discountAmount: filteredOffers[itemIndex].discountPercentage,
                                                    newPrice: filteredOffers[itemIndex].newPrice ,
                                                    oldPrice: filteredOffers[itemIndex].oldPrice,
                                                    place: filteredOffers[itemIndex].place,
                                              ),
                                            ),
                                          );
                                        },
                                        child: itemIndex < filteredOffers.length
                                            ? OfferCard(
                                                companyOffersModel:
                                                    filteredOffers[itemIndex])
                                            : Container());
                                  } else {
                                    return Container(); // If no more items, return an empty widget
                                  }
                                },
                              ),
                              itemCount: itemsPerPage,
                            ),
                            SizedBox(height: 75),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1100),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                            gradient: LinearGradient(colors: [
                              Color(0xffD8BCB0),
                              Color(0xffD1A994),
                              Color(0xffD2A288),
                              Color(0xffD2A288),
                              Color(0xffD1A994),
                              Color(0xffD8BCB0),
                            ]),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 7,
                                spreadRadius: 4,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                child: Center(
                                  child: SingleChildScrollView(
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: pages.map((page) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentPage = page;
                                              _scrollToCurrentPage();
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: currentPage == page
                                                  ? Color(0xffD67561)
                                                  : Colors.grey.shade300,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text(
                                              page.toString(),
                                              style: TextStyle(
                                                color: currentPage == page
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
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
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        closeAll(
                              () {
                            setState(() {
                              categoryDown = false;
                              priceDown = false;
                              bottomContainer = null;
                            });
                          },
                        );
                      },
                      child: Container(
                        color: Colors.black.withOpacity(.3),
                        width: (categoryDown || priceDown) ? double.infinity : 0,
                        height: (categoryDown || priceDown)
                            ? MediaQuery.of(context).size.height
                            : 0, // Set height to screen height
                      ),
                    ),
                    Positioned.fill(
                      top: 185,
                      left: 0,
                      right: 0,
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1150),
                        child: TravelFiltration(
                          onFilterChanged: applyFilters,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
