import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/di.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/company_profile/presentation/manager/company_details_cubit.dart';
import 'package:p/screens/company_profile/presentation/widgets/tabs/tab_five.dart';
import 'package:p/screens/company_profile/presentation/widgets/tabs/tab_four.dart';
import 'package:p/screens/company_profile/presentation/widgets/tabs/tab_one.dart';
import 'package:p/screens/company_profile/presentation/widgets/tabs/tab_six.dart';
import 'package:p/screens/company_profile/presentation/widgets/tabs/tab_three.dart';
import 'package:p/screens/company_profile/presentation/widgets/tabs/tab_two.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../travel_filtration/presentation/manger/travel_filter_cubit.dart';

class CompanyProfile extends StatefulWidget {
  CompanyProfile({super.key, required this.id});
  String id;

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile>
    with SingleTickerProviderStateMixin {
  final _advancedDrawerController = AdvancedDrawerController();
  late ScrollController _scrollController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 6, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        scrollDown();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void scrollDown() {
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_advancedDrawerController.value.visible) {
          _advancedDrawerController.hideDrawer();
          return false;
        }
        return true;
      },
      child: SafeArea(
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
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => getIt<CompanyDetailsCubit>()
                    ..callData(companyId: widget.id)),
              BlocProvider(
                create: (context) {
                  final cubit = getIt<TravelFilterCubit>()..getCategories();

                  cubit.setOnFilterChanged(
                    onFilterChanged: ({
                      int? category,
                      RangeValues? priceRange,
                      String? priceOrder,
                    }) {
                      final tabType =
                          CompanyDetailsCubit.get(context).currentTab;
                      final companyId = widget.id;
                      final companyCubit = CompanyDetailsCubit.get(context);

                      switch (tabType) {
                        case TravelTabType.newest:
                          companyCubit.getNewest(
                            companyId: companyId,
                            PageIndex: 1,
                            PageSize: 6,
                            MinPrice: priceRange?.start,
                            MaxPrice: priceRange?.end,
                            CategorieyId: category,
                            Sort: priceOrder,
                          );
                          break;
                        case TravelTabType.leavingSoon:
                          companyCubit.getLeavingSoon(
                            companyId: companyId,
                            PageIndex: 1,
                            PageSize: 6,
                            MinPrice: priceRange?.start,
                            MaxPrice: priceRange?.end,
                            CategorieyId: category,
                            Sort: priceOrder,
                          );
                          break;
                        case TravelTabType.discount:
                          companyCubit.getDiscount(
                            companyId: companyId,
                            PageIndex: 1,
                            PageSize: 6,
                            MinPrice: priceRange?.start,
                            MaxPrice: priceRange?.end,
                            CategorieyId: category,
                            Sort: priceOrder,
                          );
                          break;
                        case TravelTabType.allTravels:
                          companyCubit.getTravels(
                            companyId: companyId,
                            PageIndex: 1,
                            PageSize: 6,
                            MinPrice: priceRange?.start,
                            MaxPrice: priceRange?.end,
                            CategorieyId: category,
                            Sort: priceOrder,
                          );
                          break;
                      }
                    },
                  );

                  return cubit;
                },
              )
            ],
            child: BlocConsumer<CompanyDetailsCubit, CompanyDetailsState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                var travelFilter = TravelFilterCubit.get(context);


                   var info = state.companyDetailsModel;
                  double rating = (info?.rating ?? 0.0).toDouble();

                  int fullStars = rating.floor();
                  int emptyStars = 5 - fullStars;
                  double fractional = rating - fullStars;
                  return Scaffold(
                    appBar: AppBar(
                      leading: FadeIn(
                        duration: Duration(milliseconds: 1100),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back_ios_new),
                                ),
                                state.isLoadingDetails?Shimmer.fromColors(
                                  baseColor: const Color(0xffD8D1CA),
                                  highlightColor: const Color(0xffCBC0B6),
                                  child: Container(
                                    height: 20,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,

                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ):Text(
                                  info?.companyName ?? "",
                                  style: TextStyle(
                                    fontFamily: "pop",
                                    color: Colors.black.withOpacity(.8),
                                    fontSize: 15,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _advancedDrawerController.showDrawer();
                                  },
                                  icon: ValueListenableBuilder<
                                      AdvancedDrawerValue>(
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
                                                color: Colors.black
                                                    .withOpacity(.8),
                                                key: ValueKey<bool>(
                                                    value.visible),
                                              ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                            BlocBuilder<TravelFilterCubit, TravelFilterState>(
                              builder: (context, state) {
                                final filterCubit =
                                    context.read<TravelFilterCubit>();
                                final bool isCategoryDown = state.categoryDown;
                                final bool isPriceDown = state.priceDown;

                                final bool isOverlayVisible =
                                    isCategoryDown || isPriceDown;
                                if (isOverlayVisible) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    scrollDown();
                                  });
                                }
                                return isOverlayVisible
                                    ? Positioned.fill(
                                        child: GestureDetector(
                                          onTap: () {
                                            filterCubit.closeAll();
                                          },
                                          child: Container(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),
                      leadingWidth: double.infinity,
                    ),
                    body: (state.hasErrorDetails)? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Center(child: Text("Ops somthing went wrong"),)
                    ],):SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              BlocBuilder<TravelFilterCubit, TravelFilterState>(
                                builder: (context, state) {
                                  final filterCubit =
                                      context.read<TravelFilterCubit>();

                                  final bool isCategoryDown =
                                      state.categoryDown;
                                  final bool isPriceDown = state.priceDown;
                                  return GestureDetector(
                                    onTap: () {
                                      filterCubit.closeAll();
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      width: (isCategoryDown || isPriceDown)
                                          ? double.infinity
                                          : 0,
                                      height: (isCategoryDown || isPriceDown)
                                          ? 1000
                                          : 0, // Set height to screen height
                                    ),
                                  );
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [
                                              SizedBox(height: 10),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 18),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                     state.isLoadingDetails?Shimmer.fromColors(
                                                       baseColor: const Color(0xffD8D1CA),
                                                       highlightColor: const Color(0xffCBC0B6),
                                                       child: Container(
                                                         width: 330,
                                                         height: 280,
                                                         decoration: BoxDecoration(
                                                           color: Colors.white,
                                                           borderRadius: BorderRadius.circular(20),
                                                         ),
                                                       ),
                                                     ): FadeInUp(
                                                        duration: Duration(
                                                            milliseconds: 1200),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Image.network(
                                                            info?.coverImageUrl ??
                                                                "",
                                                            width: 330,
                                                            height: 280,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 230,
                                                        left: 115,
                                                        child: state.isLoadingDetails?Shimmer.fromColors(
                                                          baseColor: const Color(0xffD8D1CA),
                                                          highlightColor: const Color(0xffCBC0B6),
                                                          child: Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Colors.white,

                                                            ),
                                                          ),
                                                        ):FadeInUp(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  1400),
                                                          child: Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle),
                                                            child: CircleAvatar(
                                                              radius: 50,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      info?.profileImageUrl ??
                                                                          ""),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 50),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 43),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    state.isLoadingDetails?Shimmer.fromColors(
                                                      baseColor: const Color(0xffD8D1CA),
                                                      highlightColor: const Color(0xffCBC0B6),
                                                      child: Container(
                                                        height: 21,
                                                        width: 160,
                                                        margin: EdgeInsets.symmetric(vertical: 5),


                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                      ),
                                                    ):FadeInUp(
                                                      duration: Duration(
                                                          milliseconds: 1700),
                                                      child: Text(
                                                        info?.companyName ??
                                                            '',
                                                        style: TextStyle(
                                                          fontFamily: "pop",
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    state.isLoadingDetails?Shimmer.fromColors(
                                                      baseColor: const Color(0xffD8D1CA),
                                                      highlightColor: const Color(0xffCBC0B6),
                                                      child: Container(
                                                        alignment: Alignment.topLeft,
                                                        width: 140,
                                                        height: 21,
                                                        margin: EdgeInsets.symmetric(vertical: 5),

                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                      ),
                                                    ):FadeInUp(
                                                      duration: Duration(
                                                          milliseconds: 1850),
                                                      child: Text(
                                                        info?.slogan ?? "",
                                                        style: TextStyle(
                                                            fontFamily: "pop",
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                   state.isLoadingDetails?Shimmer.fromColors(
                                                     baseColor: const Color(0xffD8D1CA),
                                                     highlightColor: const Color(0xffCBC0B6),
                                                     child: Container(
                                                       height: 21,
                                                       width: 170,
                                                       decoration: BoxDecoration(
                                                         color: Colors.white,
                                                         borderRadius: BorderRadius.circular(12),
                                                       ),
                                                     ),
                                                   ): FadeInUp(
                                                      duration: Duration(
                                                          milliseconds: 2000),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            info?.rating
                                                                .toString()??"",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "pop",
                                                                fontSize: 14),
                                                          ),
                                                          SizedBox(
                                                            width: 7,
                                                          ),
                                                          for (int i = 0;
                                                              i < fullStars;
                                                              i++)
                                                            Icon(Icons.star,
                                                                color: Colors
                                                                    .yellow
                                                                    .shade800,
                                                                size: 20),
                                                          if (fractional >= 0.5)
                                                            Icon(
                                                                Icons.star_half,
                                                                color: Colors
                                                                    .yellow
                                                                    .shade800,
                                                                size: 20),
                                                          for (int i = 0;
                                                              i <
                                                                  emptyStars -
                                                                      (fractional >=
                                                                              0.5
                                                                          ? 1
                                                                          : 0);
                                                              i++)
                                                            Icon(
                                                                Icons
                                                                    .star_border,
                                                                color: Colors
                                                                    .yellow
                                                                    .shade800,
                                                                size: 20),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                          BlocBuilder<TravelFilterCubit,
                                              TravelFilterState>(
                                            builder: (context, state) {
                                              final filterCubit = context
                                                  .read<TravelFilterCubit>();
                                              final bool isCategoryDown =
                                                  state.categoryDown;
                                              final bool isPriceDown =
                                                  state.priceDown;

                                              final bool isOverlayVisible =
                                                  isCategoryDown || isPriceDown;

                                              return isOverlayVisible
                                                  ? Positioned.fill(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          filterCubit
                                                              .closeAll();
                                                        },
                                                        child: Container(
                                                          color: Colors.black
                                                              .withOpacity(0.3),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox.shrink();
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  DefaultTabController(
                                    length: 6,
                                    initialIndex: 0,
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 18),
                                                  child: TabBar(
                                                    controller:
                                                        _tabController,
                                                    indicatorWeight: 3,
                                                    tabAlignment:
                                                        TabAlignment.center,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    unselectedLabelColor:
                                                        Colors.black54,
                                                    splashBorderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    indicatorColor:
                                                        Color(0xffBB875B),
                                                    dividerColor: Colors.grey,
                                                    dividerHeight: 1,
                                                    labelColor: Colors.black,
                                                    labelStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .normal),
                                                    isScrollable: true,
                                                    indicatorSize:
                                                        TabBarIndicatorSize
                                                            .tab,
                                                    tabs: [
                                                      Text("Info"),
                                                      Text("Newest travels"),
                                                      Text(
                                                          "Discount Travels"),
                                                      Text(
                                                          "Leaving soon Travels"),
                                                      Text("All travels"),
                                                      Text("Reviews"),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            BlocBuilder<TravelFilterCubit,
                                                TravelFilterState>(
                                              builder: (context, state) {
                                                final filterCubit =
                                                    context.read<
                                                        TravelFilterCubit>();
                                                final bool isCategoryDown =
                                                    state.categoryDown;
                                                final bool isPriceDown =
                                                    state.priceDown;

                                                final bool isOverlayVisible =
                                                    isCategoryDown ||
                                                        isPriceDown;

                                                return isOverlayVisible
                                                    ? Positioned.fill(
                                                        child:
                                                            GestureDetector(
                                                          onTap: () {
                                                            filterCubit
                                                                .closeAll();
                                                          },
                                                          child: Container(
                                                            color: Colors
                                                                .black
                                                                .withOpacity(
                                                                    0.3),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox.shrink();
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          child: TabBarView(
                                            controller: _tabController,
                                            children: [
                                              TabOne(
                                                isLoading: state.isLoadingDetails,
                                                data: info,
                                              ),
                                              TabTwo(
                                                companyId: widget.id,
                                              ),
                                              TabThree(
                                                companyId: widget.id,
                                              ),
                                              TabFour(
                                                companyId: widget.id,
                                              ),
                                              TabFive(
                                                companyId: widget.id,
                                              ),
                                              TabSix(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ;
              },
            ),
          ),
        ),
      ),
    );
  }
}