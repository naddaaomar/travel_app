import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'api_service.dart';

class NotificationService {
  NotificationService._();

  static const String _channelKey = 'journey_mate_channel';
  static const String _channelName = 'Journey Mate Notifications';
  static const String _channelDescription = 'Notifications for trip updates and alerts.';

  static Future<bool> _areNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications_enabled') ?? true;
  }

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: _channelKey,
          channelName: _channelName,
          channelDescription: _channelDescription,
          importance: NotificationImportance.High,
          defaultColor: ColorApp.primaryColor,
          ledColor: Colors.white,
          playSound: true,
          enableVibration: true,
        )
      ],
      debug: true,
    );

    // Only request permission if notifications are enabled in settings
    if (await _areNotificationsEnabled()) {
      final isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    }
  }

  static Future<bool> scheduleTripEndNotification({
    required int id,
    required String title,
    required String body,
    required DateTime endTime,
  }) async {
    if (!await _areNotificationsEnabled()) {
      if (kDebugMode) {
        print('Notifications are disabled in settings');
      }
      return false;
    }

    try {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: _channelKey,
          title: title,
          body: body,
        ),
        schedule: NotificationCalendar.fromDate(
          date: tz.TZDateTime.from(endTime, tz.local),
          allowWhileIdle: true,
          preciseAlarm: true,
        ),
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error scheduling notification: $e');
      }
      return false;
    }
  }

  static Future<void> cancelAllScheduledNotifications() async {
    if (!await _areNotificationsEnabled()) return;
    await AwesomeNotifications().cancelAllSchedules();
  }

  static Future<void> cancelNotification(int id) async {
    if (!await _areNotificationsEnabled()) return;
    await AwesomeNotifications().cancel(id);
  }
}

class TripNotificationOrchestrator {
  final ApiService _apiService;

  TripNotificationOrchestrator({required ApiService apiService})
      : _apiService = apiService;

  Future<bool> scheduleNotificationForTrip(String tripId) async {
    try {
      // Check if notifications are enabled first
      final prefs = await SharedPreferences.getInstance();
      final notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;

      if (!notificationsEnabled) {
        if (kDebugMode) {
          print('Notifications are disabled - not scheduling trip notification');
        }
        return false;
      }

      final trip = await _apiService.getTripDetails(tripId);
      final notificationId = trip.id.hashCode;

      return await NotificationService.scheduleTripEndNotification(
        id: notificationId,
        title: 'Trip Completed!',
        body: 'Your journey to ${trip.destination} has ended. Would you like to rate it?',
        endTime: trip.endTime,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error scheduling notification for trip $tripId: $e');
      }
      return false;
    }
  }

  Future<void> cancelTripNotification(String tripId) async {
    try {
      final notificationId = tripId.hashCode;
      await NotificationService.cancelNotification(notificationId);
    } catch (e) {
      if (kDebugMode) {
        print('Error canceling notification for trip $tripId: $e');
      }
    }
  }
}