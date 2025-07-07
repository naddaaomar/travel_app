import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/di.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/company_offers/presentation/manager/company_offers_cubit.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';
import 'package:p/screens/company_offers/data/models/company_offers_model.dart';
import 'package:p/screens/tabs/offers/presentation/pages/offers_screen.dart';
import 'package:p/screens/company_offers/presentation/widgets/company_card.dart';
import 'package:p/screens/company_offers/presentation/widgets/offer_card.dart';
import 'package:p/screens/travel_filtration/presentation/pages/travel_filtration.dart';
import 'package:shimmer/shimmer.dart';
import '../../../all_companies/data/models/AllCompaniesModel.dart';
import '../../../travel_filtration/presentation/manger/travel_filter_cubit.dart';
import '../../../trip_details/views/discount_trip_details/views/discount_trip_details.dart';

class CompanyOffers extends StatefulWidget {
  CompanyOffers({super.key, required this.item});
// setState
  Items item;

  @override
  State<CompanyOffers> createState() => _CompanyOffersState();
}

class _CompanyOffersState extends State<CompanyOffers> {
  @override
  Widget build(BuildContext context) {
    String id = widget.item.id.toString();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CompanyOffersCubit>()
            ..getAllTravels(PageIndex: 1, PageSize: 5, companyId: id),
        ),
        BlocProvider(
          create: (context) {
            final cubit = getIt<TravelFilterCubit>()
              ..getCategories();

            cubit.setOnFilterChanged(
              onFilterChanged: ({
                int? category,
                RangeValues? priceRange,
                String? priceOrder,
              }) {
                CompanyOffersCubit.get(context).getAllTravels(
                  PageIndex: 1,
                  PageSize: 5,
                  companyId: id,
                  MinPrice: priceRange?.start,
                  CategorieyId: category,
                  MaxPrice: priceRange?.end,
                  Sort: priceOrder,
                );
              },
            );

            return cubit;
          },
        ),
      ],
      child: BlocConsumer<CompanyOffersCubit, CompanyOffersState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = CompanyOffersCubit.get(context);
          var filterCubit = TravelFilterCubit.get(context);
          final totalPages = state.allTravelsModel != null
              ? state.allTravelsModel!.totalPages ?? 0
              : 0;

          return SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                if (cubit.advancedDrawerController.value.visible) {
                  cubit.advancedDrawerController.hideDrawer();
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
                controller: cubit.advancedDrawerController,
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
                  controller: cubit.advancedDrawerController,
                ),
                child: Scaffold(
                  body: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.arrow_back_ios_new)),
                                  IconButton(
                                    onPressed: () {
                                      cubit.advancedDrawerController
                                          .showDrawer();
                                    },
                                    icon: ValueListenableBuilder<
                                        AdvancedDrawerValue>(
                                      valueListenable:
                                          cubit.advancedDrawerController,
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
                                                  color: Colors.black
                                                      .withOpacity(.8),
                                                  key: ValueKey<bool>(
                                                      value.visible),
                                                ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CompanyCard(
                              id: widget.item.id.toString() ?? "",
                              img: widget.item.profileImageUrl ?? "",
                              companyName: widget.item.companyName ?? "",
                            ),
                            Positioned.fill(
                              top: 215,
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.only(top: 0),
                                child: Column(
                                  children: [
                                    if(state.isLoading)(
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          padding: EdgeInsets.symmetric(vertical: 20),
                                          itemCount: 6,
                                          itemBuilder: (context, index) =>
                                              Shimmer.fromColors(
                                                baseColor: Color(0xffD8D1CA),
                                                highlightColor: Color(0xffCBC0B6),
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 16, vertical: 10),
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                ),
                                              ),
                                        )
                                    ),
                                    if(state.allTravelsModel?.items?.isEmpty ?? true)Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 150),
                                      child: FadeIn(
                                        duration: Duration(milliseconds: 800),
                                        child: (
                                        Text("No travels found")
                                        ),
                                      ),
                                    ),
                                    if(state.allTravelsModel!=null)
                                    (LiveList(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 15),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      showItemInterval:
                                          Duration(milliseconds: 150),
                                      showItemDuration:
                                          Duration(milliseconds: 350),
                                      reAnimateOnVisibility: false,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: animationItemBuilder(
                                            (index) {
                                          final items = state.allTravelsModel?.items;
                                          if (items == null || items.length <= index) {
                                            return SizedBox.shrink();
                                          }
                                          return InkWell(
                                            onTap: () {
                                              // You can navigate to details page here if needed
                                            },
                                            child: OfferCard(companyOffersModel: items[index]),
                                          );
                                        },
                                      ),

                                      itemCount: state
                                              .allTravelsModel!.items?.length ??
                                          0,
                                    )),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.chevron_left),
                                        onPressed: cubit.currentPage > 1
                                            ? () {
                                                cubit.getAllTravels(
                                                  PageIndex:
                                                      cubit.currentPage - 1,
                                                  companyId: id,
                                                  PageSize: 6,
                                                );
                                              }
                                            : null,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: SingleChildScrollView(
                                            controller: cubit.scrollController,
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: List.generate(
                                                  totalPages.toInt(), (index) {
                                                final pageNum = index + 1;
                                                final isCurrent =
                                                    cubit.currentPage ==
                                                        pageNum;
                                                return GestureDetector(
                                                  onTap: () {
                                                    cubit.getAllTravels(
                                                        PageIndex: pageNum,
                                                        companyId: id,
                                                        PageSize: 5);
                                                    cubit.scrollToCurrentPage();
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: isCurrent
                                                          ? Color(0xffD67561)
                                                          : Colors
                                                              .grey.shade300,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Text(
                                                      '$pageNum',
                                                      style: TextStyle(
                                                        color: isCurrent
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
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.chevron_right),
                                        onPressed: cubit.currentPage <
                                                totalPages
                                            ? () {
                                                cubit.getAllTravels(
                                                    PageIndex:
                                                        cubit.currentPage + 1,
                                                    PageSize: 5,
                                                    companyId: id);
                                                cubit.scrollToCurrentPage();
                                              }
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            BlocBuilder<TravelFilterCubit, TravelFilterState>(
                              builder: (context, state) {
                                final filterCubit =
                                    context.read<TravelFilterCubit>();

                                final bool isCategoryDown = state.categoryDown;
                                final bool isPriceDown = state.priceDown;
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
                              top: 165,
                              left: 0,
                              right: 0,
                              child: FadeInUp(
                                duration: Duration(milliseconds: 1150),
                                child: TravelFiltration(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
