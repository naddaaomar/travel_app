import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/tabs/home/data/models/TravelRecommendation.dart';
import 'package:shimmer/shimmer.dart';

class ViewAllTravelRecommendations extends StatelessWidget {
  final List<TravelRecommendation>? travels;

  const ViewAllTravelRecommendations({super.key, required this.travels});

  @override
  Widget build(BuildContext context) {
    final list = travels ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text(
          'Travels Recommendations',
          style: TextStyle(
            color: ColorApp.thirdColor,
            fontWeight: FontWeight.bold,
            fontFamily: "vol",
            fontSize: 15,
          ),
        ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final travel = list[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: SizedBox(
                height: 140.h,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  elevation: 6,
                  child: Row(
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(10.r)),
                        child: Image.network(
                          travel.coverImageUrl ?? '',
                          width: 130.w,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Image.asset(
                            'assets/images/no_image.png',
                            width: 130.w,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.white,
                              child: Container(
                                width: 130.w,
                                height: double.infinity,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      // Info
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 8.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                travel.title ?? "No Title",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      size: 14.sp,
                                      color: ColorApp.primaryColor),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: Text(
                                      travel.startDate?.split("T").first ??
                                          "Unknown Date",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey[700]),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 16.sp,
                                      color: ColorApp.primaryColor),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: Text(
                                      travel.destinationCity ?? "Unknown",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey[700]),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
