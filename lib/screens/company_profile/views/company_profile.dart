import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/company_offers/presentation/manager/travel_filter_cubit/travel_filter_cubit.dart';
import 'package:p/screens/company_profile/manager/company_details_cubit.dart';
import 'package:p/screens/company_profile/widgets/tabs/tab_five.dart';
import 'package:p/screens/company_profile/widgets/tabs/tab_four.dart';
import 'package:p/screens/company_profile/widgets/tabs/tab_one.dart';
import 'package:p/screens/company_profile/widgets/tabs/tab_three.dart';
import 'package:p/screens/company_profile/widgets/tabs/tab_two.dart';
import 'package:p/screens/company_profile/widgets/tabs/trip_card.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';

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
    _tabController = TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _scrollDown();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _scrollDown() {
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
          create: (context) =>
              CompanyDetailsCubit()..getCompanyDetails(id: widget.id),
),
    BlocProvider(
      create: (context) => TravelFilterCubit(),
    ),
  ],
  child: BlocConsumer<CompanyDetailsCubit, CompanyDetailsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var travelFilter= TravelFilterCubit.get(context);
              if (state is CompanyDetailsSuccess) {
                var info = state.companyDetailsModel;
                double rating = (info.rating ?? 0.0).toDouble();

                int fullStars = rating.floor();
                int emptyStars = 5 - fullStars;
                double fractional = rating - fullStars;
                return Scaffold(
                  appBar: AppBar(
                    leading: FadeInUp(
                      duration: Duration(milliseconds: 1100),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                    title: FadeInUp(
                      duration: Duration(milliseconds: 1100),
                      child: Text(
                        info.companyName ?? "",
                        style: TextStyle(
                          fontFamily: "pop",
                          color: Colors.black.withOpacity(.8),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    centerTitle: true,
                    actions: [
                      FadeInUp(
                        duration: Duration(milliseconds: 1100),
                        child: IconButton(
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
                      )
                    ],
                  ),
                  body: SingleChildScrollView(
                    controller:
                        _scrollController,
                    child: Column(
                      children: [
                        Stack(
                          children: [

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
                                    color: Colors.transparent,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 18),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        FadeInUp(
                                          duration: Duration(milliseconds: 1200),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              info.coverImageUrl??"",
                                              width: 330,
                                              height: 280,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 230,
                                          left: 115,
                                          child: FadeInUp(
                                            duration: Duration(milliseconds: 1400),
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              decoration:
                                                  BoxDecoration(shape: BoxShape.circle),
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: NetworkImage(
                                                    info.profileImageUrl ?? ""),
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
                                  padding: const EdgeInsets.symmetric(horizontal: 43),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FadeInUp(
                                        duration: Duration(milliseconds: 1700),
                                        child: GestureDetector(
                                          onTap:
                                              () {
                                            print(travelFilter.categoryDown);
                                            print(travelFilter.categoryDown);
                                            print(travelFilter.categoryDown);
                                            print(travelFilter.priceDown);
                                            print(travelFilter.priceDown);
                                            print(travelFilter.priceDown);
                                          },
                                          child: Text(
                                            info.companyName ?? '',
                                            style: TextStyle(
                                              fontFamily: "pop",
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      FadeInUp(
                                        duration: Duration(milliseconds: 1850),
                                        child: Text(
                                          info.slogan ?? "",
                                          style: TextStyle(
                                              fontFamily: "pop",
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
                                        ),
                                      ),
                                      FadeInUp(
                                        duration: Duration(milliseconds: 2000),
                                        child: Row(
                                          children: [
                                            Text(
                                              info.rating.toString(),
                                              style: TextStyle(
                                                fontFamily: "pop",
                                                fontSize: 14
                                              ),
                                            ),
                                            SizedBox(width: 7,),
                                            for (int i = 0; i < fullStars; i++)
                                              Icon(Icons.star,
                                                  color: Colors.yellow.shade800,
                                                  size: 20),
                                            if (fractional >= 0.5)
                                              Icon(Icons.star_half,
                                                  color: Colors.yellow.shade800,
                                                  size: 20),
                                            for (int i = 0;
                                                i <
                                                    emptyStars -
                                                        (fractional >= 0.5 ? 1 : 0);
                                                i++)
                                              Icon(Icons.star_border,
                                                  color: Colors.yellow.shade800,
                                                  size: 20),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                FadeInUp(
                                  duration: Duration(milliseconds: 2150),
                                  child: DefaultTabController(
                                    length: 5,
                                    initialIndex: 0,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 18),

                                          child: TabBar(
                                            controller: _tabController,
                                            indicatorWeight: 3,
                                            tabAlignment: TabAlignment.center,
                                            padding:
                                                EdgeInsets.symmetric(horizontal: 20),
                                            unselectedLabelColor: Colors.black54,
                                            splashBorderRadius:
                                                BorderRadius.circular(5),
                                            indicatorColor: Color(0xffBB875B),
                                            dividerColor: Colors.grey,
                                            dividerHeight: 1,
                                            labelColor: Colors.black,
                                            labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                            isScrollable: true,
                                            indicatorSize: TabBarIndicatorSize.tab,
                                            tabs: [
                                              Text("Info"),
                                              Text("Top rated trips"),
                                              Text("Discount trips"),
                                              Text("All trips"),
                                              Text("Reviews"),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height /
                                              1.5,
                                          child: TabBarView(
                                            controller: _tabController,
                                            children: [
                                              TabOne(data: info,),
                                              TabTwo(
                                                card: TripCard(),
                                              ),
                                              TabThree(),
                                              TabFour(),
                                              TabFive(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),




                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is CompanyDetailsLoading) {
                return Scaffold(
                    body: Center(
                        child: CircularProgressIndicator(
                  color: ColorApp.primaryColor,
                )));
              }
              return Scaffold(
                body: Text("Something went wrong "),
              );
            },
          ),
),
      ),
    );
  }
}
