import 'package:auto_animated/auto_animated.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/all_companies/manager/all_com_cubit.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/offers/presentation/pages/company_offers.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/companies.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/company_home_card.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/dont_miss.dart';

class OffersScreen extends StatefulWidget {
  OffersScreen({super.key});

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  // List<CompanyModel> companies = [];
  // int page = 1;
  // bool isLoading = false;
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _fetchCompanies();
    //
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels >=
    //       _scrollController.position.maxScrollExtent - 100 &&
    //       !isLoading) {
    //     _fetchCompanies();
    //   }
    // });
  }

  // Future<void> _fetchCompanies() async {
  //   if (isLoading || companies.length >= 30) return;
  //
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   await Future.delayed(Duration(seconds: 1));
  //
  //   int remaining = 30 - companies.length;
  //   int fetchCount = remaining >= 10 ? 10 : remaining;
  //
  //   List<CompanyModel> newCompanies = List.generate(
  //     fetchCount,
  //         (index) =>
  //         CompanyModel(
  //           label: "Company ${index + 1 + (page - 1) * 10}",
  //           imagePath: "assets/images/dahab5.jpg",
  //         ),
  //   );
  //
  //   setState(() {
  //     companies.addAll(newCompanies);
  //     page++;
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: BlocProvider(
        create: (context) => AllComCubit()..getCom(),
        child: BlocConsumer<AllComCubit, AllComState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is Success) {
              return SingleChildScrollView(
                // controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "don't miss".tr(),
                      style: TextStyle(
                          fontFamily: "vol",
                          fontWeight: FontWeight.w500,
                          fontSize: 22.sp,
                          color: isLight ? Colors.black : Colors.white),
                    ),
                    DontMiss(),
                    SizedBox(height: 10.h),
                    Text(
                      "discover exclusive offers \nfrom top companies tailored just for you"
                          .tr(),
                      maxLines: 2,
                      style: TextStyle(
                          fontFamily: "vol",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: isLight ? Colors.black : Colors.white),
                    ),
                    SizedBox(height: 15),
                    LiveGrid(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      visibleFraction: 0.001,
                      showItemInterval: Duration(milliseconds: 80),
                      showItemDuration: Duration(milliseconds: 150),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: .86,
                          crossAxisCount: 2,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 0),
                      itemBuilder:
                          animationItemBuilder((index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CompanyOffers(
                                        item: state.allCompanies.items![index],
                                      ),
                                    ));
                              },
                              child: CompanyHomeCard(
                                allCompanies: state.allCompanies.items![index],
                              ))),
                      itemCount: state.allCompanies.items?.length ?? 0,
                    ),
                    if (state is Loading)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
              );
            }
            ;
            if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorApp.primaryColor,
                ),
              );
            }
            return Text("SomeThing went wrong");
          },
        ),
      ),
    );
  }
}

Widget Function(
  BuildContext context,
  int index,
  Animation<double> animation,
) animationItemBuilder(
  Widget Function(int index) child, {
  EdgeInsets padding = EdgeInsets.zero,
}) =>
    (
      BuildContext context,
      int index,
      Animation<double> animation,
    ) =>
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            child: Padding(
              padding: padding,
              child: child(index),
            ),
          ),
        );