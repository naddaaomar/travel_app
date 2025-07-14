// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:p/screens/tabs/home/data/models/TravelRecommendation.dart';
//
// class TravelRecommend extends StatelessWidget {
//   TravelRecommend({super.key, required this.travel});
//
//   final List<TravelRecommendation>? travel;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Travel Recommendations"),
//       ),
//       body: travel == null || travel!.isEmpty
//           ? const Center(child: Text("No travel recommendations available."))
//           : ListView.builder(
//         padding: EdgeInsets.all(16.w),
//         itemCount: travel!.length,
//         itemBuilder: (context, index) {
//           final item = travel![index];
//
//           return Card(
//             margin: EdgeInsets.only(bottom: 16.h),
//             elevation: 4,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Image
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//                   child: Image.network(
//                     item.c ?? '',
//                     width: double.infinity,
//                     height: 180.h,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => Container(
//                       height: 180.h,
//                       color: Colors.grey[300],
//                       child: const Center(child: Icon(Icons.image_not_supported)),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(12.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         item.title ?? 'No Title',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       // SizedBox(height: 6.h),
//                       // if (item.date != null)
//                       //   Text("📅 ${item.date!}", style: TextStyle(fontSize: 13.sp)),
//                       // if (item.location != null)
//                       //   Text("📍 ${item.location!}", style: TextStyle(fontSize: 13.sp)),
//                       // if (item.category != null)
//                       //   Text("🗂 ${item.category!}", style: TextStyle(fontSize: 13.sp)),
//                       // SizedBox(height: 10.h),
//                       // ElevatedButton(
//                       //   onPressed: () {
//                       //     // Open external link
//                       //     if (item.link != null) {
//                       //       launchUrl(Uri.parse(item.link!));
//                       //     }
//                       //   },
//                       //   child: const Text("More Details"),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
