import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/di.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/ai/Ai_requests.dart';
import 'package:p/screens/view_all_events/presentation/pages/view_all_recommended_events.dart';
import 'package:p/screens/search/presentation/pages/location_card_new.dart';
import 'package:p/screens/newest_view_all/presentation/pages/all_newest.dart';
import 'package:p/screens/tabs/home/presentation/manager/home_cubit.dart';
import 'package:p/screens/tabs/home/presentation/widgets/nearby_places.dart';
import 'package:p/screens/tabs/home/presentation/widgets/recommended_places.dart';
import 'dart:ui' as ui;

import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/trip_details/views/widgets/view_all_nearby_trips.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context
        .watch<ThemeBloc>()
        .state == ThemeMode.light;
    return BlocProvider(
      create: (context) =>
      getIt<HomeCubit>()
        ..call(PageIndex: 1, PageSize: 6),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LocationCardNew(),
                    SizedBox(
                      height: 20,
                    ),
                    // LocationCard(),
                    // SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            final token = await prefs.getString('token');
                            final userId = await prefs.getString('user_id');
                            print(token);
                            print("////////////////////////////////////////////");
                            print(userId);
                            final aiRequests = AiRequests();

                            await aiRequests.syncInteractionStatesFromRemote(); // fetch favs + bookings
                            await aiRequests.sendUserInteractions(userId??""); // send to AI endpoint

                            print("✅ AI sync test completed.");

                          },
                          child: Text(
                            'Events',
                            style: TextStyle(
                                fontFamily: "vol",
                                fontWeight: FontWeight.w600,
                                fontSize: 17.sp,
                                color: isLight ? Colors.black : Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewAllEvents(eventModel: state.eventsModel,)));
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          child: Text(
                            'view All'.tr(),
                            style: TextStyle(
                                fontFamily: "vol",
                                fontSize: 13.sp,
                                color: isLight ? ColorApp.thirdColor : Colors
                                    .white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 9.h),
                    RecommendedPlaces(),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Newest',
                          style: TextStyle(
                              fontFamily: "vol",
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                              color: isLight ? Colors.black : Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllNewest()));
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          child: Text(
                            'view All'.tr(),
                            style: TextStyle(
                                fontFamily: "vol",
                                fontSize: 13.sp,
                                color: isLight ? ColorApp.thirdColor : Colors
                                    .white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7.h),
                    NearbyPlaces(),
                    SizedBox(height: 75.h),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
