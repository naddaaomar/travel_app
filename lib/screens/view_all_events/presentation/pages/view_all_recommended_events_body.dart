import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/di.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/event_details/presentation/pages/event_details_view_body.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'package:p/screens/view_all_events/presentation/manager/all_events_cubit.dart';
import 'package:shimmer/shimmer.dart';


class ViewAllEventsBody extends StatelessWidget {
  ViewAllEventsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return BlocProvider(
      create: (context) => getIt<AllEventsCubit>()..getEvents(),
      child: BlocConsumer<AllEventsCubit, AllEventsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.isLoading) {
            return ListView.builder(
              itemCount: 6,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              itemBuilder: (_, __) => _buildEventShimmer(),
            );
          }

          final events = state.eventsModel ?? [];

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 18.h),
                child: SizedBox(
                  height: 140.h,
                  width: double.infinity,
                  child: Card(
                    color: isLight ? Colors.white : ColorApp.cardColorDark,
                    elevation: 10,
                    shadowColor:
                    isLight ? ColorApp.primaryColor : ColorApp.primaryColorDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.r),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EventDetailsViewBody(id: event!.id.toString()),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0.h),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                event?.image ?? '',
                                height: double.infinity,
                                width: 130.w,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: Colors.grey,
                                  width: 130.w,
                                  height: double.infinity,
                                  child: Icon(Icons.broken_image,
                                      color: Colors.white),
                                ),
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Shimmer.fromColors(
                                    baseColor: ColorApp.baseColor,
                                    highlightColor: ColorApp.highlightColor,
                                    child: Container(
                                      height: double.infinity,
                                      width: 130.w,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(4.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      event?.title ?? "No Title",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: isLight ? Colors.black : Colors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today,
                                            color: ColorApp.primaryColor,
                                            size: 14.sp),
                                        SizedBox(width: 5.w),
                                        Expanded(
                                          child: Text(
                                            event?.dates ??
                                                event?.date ??
                                                'No date available',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color:
                                              isLight ? Colors.black : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Ionicons.location,
                                            color: ColorApp.primaryColor,
                                            size: 16.sp),
                                        SizedBox(width: 5.w),
                                        Expanded(
                                          child: Text(
                                            event?.location ?? 'Unknown Location',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color:
                                              isLight ? Colors.black : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
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
            },
          );
        },
      ),
    );
  }

  Widget _buildEventShimmer() {
    return Shimmer.fromColors(
      baseColor: ColorApp.baseColor,
      highlightColor: ColorApp.highlightColor,
      child: Container(
        height: 140.h,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}