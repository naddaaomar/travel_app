// import 'package:hive/hive.dart';
// import 'package:p/helpers/api_manager/api_manager.dart';
// import 'package:p/helpers/constants/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'models/event_interaction.dart';
//
// Future<List<String>> getBookedTravelIds() async {
//   ApiManager apiManager = ApiManager();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final token = await prefs.getString('token');
//   final response = await apiManager.getData(
//     endPoint: Constants.bookingEndpoint,
//     headers: {"Authorization": 'Bearer $token'},
//   );
//
//   final bookings = response.data as List;
//
//   final bookedIds = bookings
//       .where((b) => b["status"] == "Payment Successed")
//       .map<String>((b) => b["bookingItem"]["travelId"].toString())
//       .toList();
//
//   return bookedIds;
// }
//
// Future<void> syncInteractionStatesFromRemote({
//   required List<String> favoriteIds,
//   required List<String> bookedIds,
// }) async {
//   final box = Hive.box<EventInteraction>('interactions');
//
//   for (int i = 0; i < box.length; i++) {
//     final interaction = box.getAt(i);
//     if (interaction == null) continue;
//
//     final isFav = favoriteIds.contains(interaction.id);
//     final isBooked = bookedIds.contains(interaction.id);
//
//     bool changed = false;
//
//     if (interaction.addedToWishList != isFav) {
//       interaction.addedToWishList = isFav;
//       changed = true;
//     }
//
//     if (interaction.booked != isBooked) {
//       interaction.booked = isBooked;
//       changed = true;
//     }
//
//     if (changed) {
//       interaction.recalculateTotal();
//       await interaction.save();
//     }
//   }
// }
//
// Future<List<String>> getFavoriteTravelIds() async {
//   ApiManager apiManager = ApiManager();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final token = await prefs.getString('token');
//   final response = await apiManager.getData(
//     endPoint: "/api/Travel/Favtravels",
//     headers: {"Authorization": 'Bearer $token'},
//   );
//
//   final favs = response.data as List;
//
//   final favIds = favs.map<String>((f) => f["id"].toString()).toList();
//
//   return favIds;
// }
//
// Future<void> trackInteractionClick({
//   required String contentId,
//   required String type, // 'event' or 'travel'
// }) async {
//   final box = Hive.box<EventInteraction>('interactions');
//
//   final index = box.values
//       .toList()
//       .indexWhere((e) => e.id == contentId && e.type == type);
//
//   if (index != -1) {
//     final item = box.getAt(index);
//     if (item != null) {
//       item.userCheckOut += 1;
//       item.recalculateTotal();
//       await item.save();
//     }
//   } else {
//     final newItem = EventInteraction(
//       id: contentId,
//       type: type,
//       userCheckOut: 1,
//       addedToWishList: false,
//       booked: false,
//     );
//     await box.add(newItem);
//   }
// }