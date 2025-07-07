import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/home/presentation/manager/home_cubit.dart';
import 'package:shimmer/shimmer.dart';

class NearbyPlaces extends StatelessWidget {
  const NearbyPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is NewestLoading) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20),
            itemCount: 6,
            itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: Color(0xffD8D1CA),
              highlightColor: Color(0xffCBC0B6),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        }
        if (state is NewestSuccess) {
          var info = state.newestModel.items!;
          return MaterialButton(
            onPressed: () {},
            child: Column(
              children: List.generate(state.newestModel.items!.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: SizedBox(
                    height: 130.h,
                    width: double.maxFinite,
                    child: Card(
                      color: isLight ? Colors.white : ColorApp.cardColorDark,
                      elevation: 10,
                      shadowColor: isLight
                          ? ColorApp.primaryColor
                          : ColorApp.primaryColorDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.r),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => TripDetailsViewBody(
                          //         image: nearbyPlaces[index].image,
                          //       ),
                          //     ));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0.h),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: CachedNetworkImage(
                                  imageUrl: info[index].coverImageUrl ?? "",
                                  height: double.maxFinite,
                                  width: 130.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Shimmer.fromColors(
                                    baseColor: const Color(0xffD8D1CA),
                                    highlightColor: const Color(0xffCBC0B6),
                                    child: Container(
                                      height: double.maxFinite,
                                      width: 130.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Image.asset(
                                    "assets/images/no_image.png",
                                    height: double.maxFinite,
                                    width: 130.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.newestModel.items![index].title ??
                                          "",
                                      style: TextStyle(
                                          fontFamily: "pop",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isLight
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      info[index].companyName ?? "",
                                      style: TextStyle(
                                          fontFamily: "pop",
                                          fontSize: 11,
                                          color: isLight
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                    SizedBox(height: 10.h),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                fontFamily: "pop",
                                                fontSize: 14.sp,
                                                color: isLight
                                                    ? ColorApp.primaryColor
                                                    : Colors.white,
                                              ),
                                              text: info[index]
                                                      .price
                                                      .toString() ??
                                                  "",
                                              children: [
                                                TextSpan(
                                                    style: TextStyle(
                                                      fontFamily: "pop",
                                                      fontSize: 12.sp,
                                                      color: isLight
                                                          ? Colors.black54
                                                          : Colors.white,
                                                    ),
                                                    text: "/ Person")
                                              ]),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }
        return FadeIn(
          duration: Duration(milliseconds: 700),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Text("Ops something went wrong",
            style: TextStyle(
              fontFamily: "pop",
              color: Colors.black54,
              fontSize: 13,
              fontWeight: FontWeight.w500
            ),),
          ),
        );
      },
    );
  }
}
