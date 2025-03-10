import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/company_profile/widgets/tabs/tab_five.dart';
import 'package:p/screens/company_profile/widgets/tabs/tab_four.dart';
import 'package:p/screens/company_profile/widgets/tabs/tab_one.dart';
import 'package:p/screens/company_profile/widgets/tabs/tab_three.dart';
import 'package:p/screens/company_profile/widgets/tabs/tab_two.dart';
import 'package:p/screens/company_profile/widgets/tabs/trip_card.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';

class CompanyProfile extends StatefulWidget {
  CompanyProfile({super.key});

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
        child: Scaffold(
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
                "Terhal",
                style: TextStyle(
                  color: Colors.black.withOpacity(.8),
                  fontSize: 18,
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              controller: _scrollController, // Attach the ScrollController
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        FadeInUp(
                          duration: Duration(milliseconds: 1200),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/images/company_pic.jpeg",
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
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage("assets/images/terhaal.jpg"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          duration: Duration(milliseconds: 1700),
                          child: Text(
                            "Terhal",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1850),
                          child: Text(
                            "Unveil the Wonders of Egypt",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 2000),
                          child: Row(
                            children: [
                              Text(
                                "4.6",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(width: 7),
                              Icon(Icons.star, color: Colors.yellow[800]),
                              Icon(Icons.star, color: Colors.yellow[800]),
                              Icon(Icons.star, color: Colors.yellow[800]),
                              Icon(Icons.star, color: Colors.yellow[800]),
                              Icon(Icons.star_half_outlined,
                                  color: Colors.yellow[800]),
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
                          TabBar(

                            controller: _tabController,
                            indicatorWeight: 3,
                            tabAlignment: TabAlignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            unselectedLabelColor: Colors.black54,
                            splashBorderRadius: BorderRadius.circular(5),
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
                              Text("Description"),
                              Text("Top rated trips"),
                              Text("Discount trips"),
                              Text("All trips"),
                              Text("Reviews"),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: TabBarView(

                              controller: _tabController,
                              children: [
                                TabOne(),
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
            ),
          ),
        ),
      ),
    );
  }
}
