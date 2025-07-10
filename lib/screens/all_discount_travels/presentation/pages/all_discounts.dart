import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/all_discount_travels/presentation/manager/all_discounts_cubit.dart';
import 'package:p/screens/all_discount_travels/presentation/widgets/all_discount_card.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';
import 'package:p/screens/tabs/offers/presentation/pages/offers_screen.dart';
import 'package:p/screens/travel_filtration/presentation/manger/travel_filter_cubit.dart';
import 'package:p/screens/travel_filtration/presentation/pages/travel_filtration.dart';
import 'package:p/screens/trip_details/views/trip_details_view_body.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../di.dart';

class AllDiscounts extends StatelessWidget {
  AllDiscounts({super.key});

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt<AllDiscountsCubit>()
                        ..getAllDiscounts(PageIndex: 1, PageSize: 6),
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
                            AllDiscountsCubit.get(context).getAllDiscounts(
                              PageIndex: 1,
                              PageSize: 6,
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
                  child: Stack(
                    children: [
                      FadeInUp(
                        duration: Duration(milliseconds: 800),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 22,
                                  )),
                              Image.asset(
                                "assets/images/logo.png",
                                width: 100,
                              ),
                              IconButton(
                                onPressed: () {
                                  _advancedDrawerController.showDrawer();
                                },
                                icon:
                                ValueListenableBuilder<AdvancedDrawerValue>(
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
                                        color:
                                        Colors.black.withOpacity(.8),
                                        key:
                                        ValueKey<bool>(value.visible),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Container(
                            margin: EdgeInsets.only(top: 60),
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffD3978F),
                                  Color(0xffC15643),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Text(
                              "Discover Discounts",
                              style: TextStyle(
                                fontFamily: "vol",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 140),
                        child:
                        BlocConsumer<AllDiscountsCubit, AllDiscountsState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state.isLoading) {
                              return ListView.builder(
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
                              );
                            }
                            if (state.allTravelsModel?.items?.isEmpty ?? true) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 300),
                                child: Align(
                                    alignment: Alignment.topCenter,
                                    child: FadeIn(
                                      duration: Duration(milliseconds: 1000),
                                      child: const Text(
                                        "No Travels Found",
                                        style: TextStyle(
                                            fontFamily: "pop",
                                            color: Colors.black54),
                                      ),
                                    )),
                              );
                            }

                            if (state.allTravelsModel != null) {
                              var cubit = AllDiscountsCubit.get(context);
                              return SingleChildScrollView(
                                padding: const EdgeInsets.only(bottom: 100),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    LiveList(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 10),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 20),
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
                                          final items =
                                              state.allTravelsModel?.items;
                                          if (items == null ||
                                              items.length <= index) {
                                            return SizedBox
                                                .shrink(); // أو أي ويدجت بديلة
                                          }
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        TripDetailsViewBody(
                                                            id: state
                                                                .allTravelsModel!
                                                                .items![index]
                                                                .id
                                                                .toString()),
                                                  ));
                                            },
                                            child: AllDiscountCard(
                                              items: items[index],
                                            ),
                                          );
                                        },
                                      ),
                                      itemCount: state
                                          .allTravelsModel!.items?.length ??
                                          0,
                                    ),
                                  ],
                                ),
                              );
                            }

                            return Center(
                              child: Text(
                                "Something went wrong",
                                style: TextStyle(
                                  color: ColorApp.primaryColor,
                                  fontFamily: "pop",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: FadeInUp(
                          duration: Duration(milliseconds: 1100),
                          child: Container(
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
                            child: BlocBuilder<AllDiscountsCubit,
                                AllDiscountsState>(
                              builder: (context, state) {
                                final cubit = AllDiscountsCubit.get(context);
                                final totalPages = state.allTravelsModel != null
                                    ? state.allTravelsModel!.totalPages ?? 0
                                    : 0;

                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.chevron_left),
                                      onPressed: cubit.currentPage > 1
                                          ? () {
                                        cubit.getAllDiscounts(
                                          PageIndex:
                                          cubit.currentPage - 1,
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
                                                  cubit.currentPage == pageNum;
                                              return GestureDetector(
                                                onTap: () {
                                                  cubit.getAllDiscounts(
                                                      PageIndex: pageNum,
                                                      PageSize: 6);
                                                  cubit.scrollToCurrentPage();
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: isCurrent
                                                        ? Color(0xffD67561)
                                                        : Colors.grey.shade300,
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
                                      onPressed: cubit.currentPage < totalPages
                                          ? () {
                                        cubit.getAllDiscounts(
                                          PageIndex:
                                          cubit.currentPage + 1,
                                          PageSize: 6,
                                        );
                                        cubit.scrollToCurrentPage();
                                      }
                                          : null,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<TravelFilterCubit, TravelFilterState>(
                        builder: (context, state) {
                          final filterCubit = context.read<TravelFilterCubit>();

                          // Read directly from cubit fields (even if not part of state)
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
                        top: 100,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}