import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/event_interaction.dart';

class AiRequests {
  ApiManager apiManager=ApiManager();



  // Send all user interactions to the AI endpoint
  Future<void> sendUserInteractions(String userId) async {
    final Box<EventInteraction> box = Hive.box<EventInteraction>('interactions');

    if (box.isEmpty) return;

    final List<Map<String, dynamic>> interactions = box.values.map((interaction) {
      return {
        "id": interaction.id,
        "type": interaction.type,
        "total": interaction.total,
      };
    }).toList();

    final Map<String, dynamic> requestBody = {
      "id": userId,
      "userInteraction": interactions,
    };

    try {
      final response = await apiManager.postDate(
        endPoint: "/api/Ai/userinteractions",
        data: requestBody,
      );

      if (response.statusCode == 200) {
        await box.clear(); // Clear local interactions after successful sync
        print("✅ User interactions sent successfully.");
      } else {
        print("❌ Failed: ${response.statusCode} - ${response.statusMessage}");
      }
    } on DioException catch (e) {
      print("🚨 Dio error: ${e.message}");
    } catch (e) {
      print("🚨 Unexpected error: $e");
    }
  }

  // Save a single interaction manually (optional helper)
  Future<void> saveInteraction(EventInteraction interaction) async {
    final box = Hive.box<EventInteraction>('interactions');
    await box.add(interaction);
  }

  // Track interaction click (increase checkout count)
  Future<void> trackInteractionClick({
    required String contentId,
    required String type,
  }) async {
    final box = Hive.box<EventInteraction>('interactions');

    final index = box.values.toList().indexWhere((e) => e.id == contentId && e.type == type);

    if (index != -1) {
      final item = box.getAt(index);
      if (item != null) {
        item.userCheckOut += 1;
        item.recalculateTotal();
        await item.save();
      }
    } else {
      final newItem = EventInteraction(
        id: contentId,
        type: type,
        userCheckOut: 1,
        addedToWishList: false,
        booked: false,
      );
      await box.add(newItem);
    }
  }

  // Sync remote favorite and booking data into local Hive box
  Future<void> syncInteractionStatesFromRemote() async {
    final favIds = await getFavoriteTravelIds();
    final bookedIds = await getBookedTravelIds();
    final box = Hive.box<EventInteraction>('interactions');

    for (int i = 0; i < box.length; i++) {
      final interaction = box.getAt(i);
      if (interaction == null) continue;

      final isFav = favIds.contains(interaction.id);
      final isBooked = bookedIds.contains(interaction.id);

      bool changed = false;

      if (interaction.addedToWishList != isFav) {
        interaction.addedToWishList = isFav;
        changed = true;
      }

      if (interaction.booked != isBooked) {
        interaction.booked = isBooked;
        changed = true;
      }

      if (changed) {
        interaction.recalculateTotal();
        await interaction.save();
      }
    }
  }

  // Fetch favorite travel IDs from remote
  Future<List<String>> getFavoriteTravelIds() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString('token');
      final response = await apiManager.getData(endPoint: "/api/Travel/Favtravels",
        headers: {"Authorization": 'Bearer $token'},
      );
      final favs = response.data as List;
      return favs.map<String>((f) => f["id"].toString()).toList();
    } catch (e) {
      print("⚠️ Failed to fetch favorites: $e");
      return [];
    }
  }

  // Fetch booked travel IDs (only those with status == 'payment success')
  Future<List<String>> getBookedTravelIds() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString('token');
      final response = await apiManager.getData(endPoint: "/api/Booking",
        headers: {"Authorization": 'Bearer $token'},);
      final bookings = response.data as List;
      return bookings
          .where((b) => b["status"] == "Payment Successed")
          .map<String>((b) => b["bookingItem"]["travelId"].toString())
          .toList();
    } catch (e) {
      print("⚠️ Failed to fetch bookings: $e");
      return [];
    }
  }
}