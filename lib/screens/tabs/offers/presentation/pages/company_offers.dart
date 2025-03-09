import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/company_profile/widgets/custom_tab_bar.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';
import 'package:p/screens/tabs/offers/presentation/pages/offers_screen.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/companies.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/company_card.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/offer_card.dart';
import 'package:p/screens/trip_details/views/widgets/trip_details_view_body.dart';

class CompanyOffers extends StatefulWidget {
  CompanyOffers({super.key, required this.companyModel});
  CompanyModel companyModel;

  @override
  State<CompanyOffers> createState() => _CompanyOffersState();
}

class _CompanyOffersState extends State<CompanyOffers> {
  final _advancedDrawerController = AdvancedDrawerController();

  int currentPage = 1;
  final int itemsPerPage = 5;
  final int totalItems = 20;
  List<int> pages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    int totalPages = (totalItems / itemsPerPage).ceil();
    pages = List.generate(15, (index) => index + 1);
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
              Stack(
                clipBehavior: Clip.none,
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
                  CompanyCard()
                ],
              ),
              SizedBox(
                height: 55,
              ),
              FadeInUp(
                  duration: Duration(milliseconds: 1150),
                  child: CustomTabBar()),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      LiveList(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 15,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        showItemInterval: Duration(milliseconds: 150),
                        showItemDuration: Duration(milliseconds: 350),
                        reAnimateOnVisibility: false,
                        scrollDirection: Axis.vertical,
                        itemBuilder: animationItemBuilder(
                          (index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TripDetailsViewBody(
                                    image: "assets/images/onboard3.png",
                                  ),
                                ),
                              );
                            },
                            child: OfferCard(),
                          ),
                        ),
                        itemCount: itemsPerPage,
                      ),
                    ],
                  ),
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1100),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
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
                          color: Colors.black26, blurRadius: 7, spreadRadius: 4)
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
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: currentPage == page
                                        ? Color(0xffBD6F43)
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
            ],
          ),
        ),
      ),
    );
  }
}
