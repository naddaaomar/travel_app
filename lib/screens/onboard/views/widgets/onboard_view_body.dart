import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/main.dart';
import 'package:p/models/onboard_model.dart';
import 'package:p/screens/home/views/home_view.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';

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
      margin:  EdgeInsets.only(right: 4.w),
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
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                onboarding[index].image,
                fit: BoxFit.cover,
              );
            },
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(
                        height: 40.h),

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
                          padding:  EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 7.h,
                          ),
                        ),),),


                     SizedBox(
                        height: 10.h),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          onboarding[currentIndex].name,
                          style:  TextStyle(
                            fontSize: 40.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            height: 1,
                          ),
                        ),
                         SizedBox(
                            height: 20.h),
                         Text(
                          "no matter".tr(),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboarding.length,
                      dotIndicator,
                    ),
                  ),

                   SizedBox(
                      height: 20.h),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(35.r),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeView(),
                                ),
                                    (route) => false);
                          },

                          child:  Row(
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
                        ),
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