import 'package:auto_animated/auto_animated.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/rating_dialog.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../di.dart';
import '../../../../../helpers/themes/colors.dart';
import '../../../../company_offers/presentation/pages/company_offers.dart';
import '../../../../settings/bloc/theme_bloc/theme_bloc.dart';
import '../manager/offers_cubit.dart';
import '../widgets/company_home_card.dart';
import '../widgets/dont_miss.dart';

class OffersScreen extends StatelessWidget {
  OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: BlocProvider(
        create: (context) => getIt<OffersCubit>()
          ..intiFun(PageIndexdis: 1, PageSizedis: 20, PageSizecom: 10),
        child: BlocConsumer<OffersCubit, OffersState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = OffersCubit.get(context);
            OffersCubit.get(context).setOnFilterChanged(
              onFilterChanged: ({
                int? rate,
                String? rateingOrder,
              }) {
                OffersCubit.get(context).initPagination(
                  pageSize: 10,
                  sort: rateingOrder,
                  rate: rate,
                );
              },
            );
            return ListView(
              controller: cubit.scrollController,
              padding: const EdgeInsets.only(bottom: 20),
              children: [
                Text(
                  "don't miss".tr(),
                  style: TextStyle(
                    fontFamily: "vol",
                    fontWeight: FontWeight.w500,
                    fontSize: 22.sp,
                    color: isLight ? Colors.black : Colors.white,
                  ),
                ),
                DontMiss(),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      "Discover exclusive offers from top\ncompanies tailored just for you"
                          .tr(),
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: "vol",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: isLight ? Colors.black : Colors.white,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        final cubit =
                        OffersCubit.get(context); // ✅ Get existing cubit
                        showDialog(
                            context: context,
                            builder: (context) {
                              return BlocProvider.value(
                                value: cubit,
                                child: Dialog(
                                  backgroundColor:
                                  Colors.transparent, // Optional
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: RatingDialog(),
                                ),
                              );
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: ColorApp.primaryColor.withOpacity(.7),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(
                          Icons.tune,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                if (state.isLoadingCompanies)
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: 6,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1,
                      crossAxisCount: 2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                    ),
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: const Color(0xffD8D1CA),
                        highlightColor: const Color(0xffCBC0B6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                if (state.companies?.items?.isEmpty ?? true)
                  ( Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: const Text(
                          "No Companies Found",
                          style: TextStyle(
                              fontFamily: "pop", color: Colors.black54),
                        )),
                  )),
                if (state.companies != null)
                  LiveGrid(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    visibleFraction: 0.001,
                    showItemInterval: const Duration(milliseconds: 80),
                    showItemDuration: const Duration(milliseconds: 150),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .86,
                      crossAxisCount: 2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: animationItemBuilder((index) {
                      final item = state.companies!.items![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CompanyOffers(item: item),
                            ),
                          );
                        },
                        child: CompanyHomeCard(allCompanies: item),
                      );
                    }),
                    itemCount: state.companies!.items?.length ?? 0,
                  ),
                if (cubit.currentPage < cubit.totalPages &&
                    state.companies != null)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 70, top: 17),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorApp.primaryColor,
                      ),
                    ),
                  ),
                if (state.error != null) Center(child: Text(state.error!)),
              ],
            );
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