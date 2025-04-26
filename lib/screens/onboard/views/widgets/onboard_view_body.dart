import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/main.dart';
import 'package:p/models/onboard_model.dart';
import 'package:p/screens/home/views/home_view.dart';
import 'package:p/screens/home/views/widgets/home_view_body.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardViewBody extends StatefulWidget {
  const OnBoardViewBody({super.key});

  @override
  State<OnBoardViewBody> createState() => _WelcomePageViewBodyState();
}

class _WelcomePageViewBodyState extends State<OnBoardViewBody> {
  int currentIndex = 0;

  Widget dotIndicator(int index) {
    bool isLight = context.read<ThemeBloc>().state == ThemeMode.light;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: EdgeInsets.only(right: 4.w),
      width: 30.w,
      height: 5.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: index == currentIndex ? Colors.white : Colors.white54,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: onboarding.length + 1, // Add one extra dummy page
            onPageChanged: (value) async {
              if(value == onboarding.length){
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('onboarding_seen', true);

              }
              else {
                setState(() {
                  currentIndex = value;
                });
              }
              // if (value == onboarding.length) { // If user reaches the extra page
              //   SharedPreferences prefs = await SharedPreferences.getInstance();
              //   await prefs.setBool('onboarding_seen', true);
              //
              //   Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (_) => const HomeView()),
              //         (route) => false,
              //   );
              // } else {
              //   setState(() {
              //     currentIndex = value;
              //   });
              // }
              setState(() {
                currentIndex = value;
              });
            },
            itemBuilder: (context, index) {
              if (index == onboarding.length) {
                return HomeViewBody();
              } else {
                return Image.asset(
                  onboarding[index].image,
                  fit: BoxFit.cover,
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeView(),
                            ),
                                (route) => false);
                      },
                      child: Visibility(
                        visible: onboarding.length - 1 != currentIndex
                            ? true
                            : false,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 7.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentIndex < onboarding.length ? onboarding[currentIndex].name : "",
                          style: TextStyle(
                            fontSize: 40.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          currentIndex < onboarding.length?"no matter".tr():"",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 200.h,
              child: Column(
                children: [
                  currentIndex < onboarding.length?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboarding.length,
                      dotIndicator,
                    ),
                  ):SizedBox(),
                  SizedBox(height: 20.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35.r),
                    child: Column(
                      children: [
                        currentIndex == onboarding.length - 1
                            ? GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            await prefs.setBool('onboarding_seen', true);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeView(),
                                ),
                                    (route) => false);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.double_arrow_rounded,
                                color: Colors.white,
                                size: 44.w,
                              )
                            ],
                          ),
                        )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}