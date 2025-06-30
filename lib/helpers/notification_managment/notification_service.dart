import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'api_service.dart';

class NotificationService {
  NotificationService._();

  static const String _channelKey = 'journey_mate_channel';
  static const String _channelName = 'Journey Mate Notifications';
  static const String _channelDescription = 'Notifications for trip updates and alerts.';


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

    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  static Future<void> scheduleTripEndNotification({
    required int id,
    required String title,
    required String body,
    required DateTime endTime,
  }) async {
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
  }
}

class TripNotificationOrchestrator {
  final ApiService _apiService;

  TripNotificationOrchestrator({required ApiService apiService})
      : _apiService = apiService;

  Future<void> scheduleNotificationForTrip(String tripId) async {
    try {
      final trip = await _apiService.getTripDetails(tripId);

      final notificationId = trip.id.hashCode;

      await NotificationService.scheduleTripEndNotification(
        id: notificationId,
        title: 'Trip Completed!',
        body: 'Your journey to ${trip.destination} has ended. Would you like to rate it?',
        endTime: trip.endTime,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error scheduling notification for trip $tripId: $e');
      }
    }
  }
}