import 'package:animate_do/animate_do.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/all_companies/manager/all_com_cubit.dart';
import 'package:p/screens/all_travels/manager/all_travels_cubit.dart';
import 'package:p/screens/all_travels/widgets/all_travel_card.dart';
import 'package:p/screens/company_profile/views/company_profile.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';
import 'package:p/screens/tabs/offers/presentation/pages/offers_screen.dart';
import 'package:p/screens/trip_details/views/trip_details_view_body.dart';

class AllTravels extends StatelessWidget {
  AllTravels({super.key});

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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 70,
            leading: FadeInUp(
              duration: Duration(milliseconds: 800),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    Image.asset("assets/images/logo.png"),
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
            ),
            leadingWidth: double.infinity,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Color(0xffCDBBBB), Color(0xffEC8585)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    "Discover Travels",
                    style: TextStyle(
                      fontFamily: "vol",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocProvider(
                  create: (context) => AllTravelsCubit()..getAllTravels(),
                  child: BlocConsumer<AllTravelsCubit, AllTravelsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is AllTravelsLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorApp.primaryColor,
                          ),
                        );
                      }
                      if (state is AllTravelsSuccess) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              LiveList(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 20),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                showItemInterval: Duration(milliseconds: 150),
                                showItemDuration: Duration(milliseconds: 350),
                                reAnimateOnVisibility: false,
                                scrollDirection: Axis.vertical,
                                itemBuilder: animationItemBuilder(
                                      (index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TripDetailsViewBody(
                                                      id: state.allTravelsModel
                                                          .items![index].id
                                                          .toString()),
                                            ));
                                      },
                                      child: AllTravelsCard(
                                        allTravelsModel:
                                        state.allTravelsModel.items![index]
                                        ,
                                      ),
                                    );
                                  },
                                ),
                                itemCount:
                                state.allTravelsModel.items?.length ?? 0,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
