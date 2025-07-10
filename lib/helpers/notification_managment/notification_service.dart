// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:p/helpers/themes/colors.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
//
// class NotificationService {
//   NotificationService._();
//
//   static const String _channelKey = 'journey_mate_channel';
//   static const String _channelName = 'Journey Mate Notifications';
//   static const String _channelDescription = 'Notifications for trip updates and alerts.';
//
//   static bool _isInitialized = false;
//
//   static Future<bool> _areNotificationsEnabled() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('notifications_enabled') ?? true;
//   }
//
//   static Future<void> initialize() async {
//     if (_isInitialized) return;
//
//     try {
//       tz.initializeTimeZones();
//
//       final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//       tz.setLocalLocation(tz.getLocation(timeZoneName));
//
//       await AwesomeNotifications().initialize(
//         null,
//         [
//           NotificationChannel(
//             channelKey: _channelKey,
//             channelName: _channelName,
//             channelDescription: _channelDescription,
//             importance: NotificationImportance.High,
//             defaultColor: ColorApp.primaryColor,
//             ledColor: Colors.white,
//             playSound: true,
//             enableVibration: true,
//           )
//         ],
//         debug: true,
//       );
//
//       if (await _areNotificationsEnabled()) {
//         final isAllowed = await AwesomeNotifications().isNotificationAllowed();
//         if (!isAllowed) {
//           await AwesomeNotifications().requestPermissionToSendNotifications();
//         }
//       }
//
//       _isInitialized = true;
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error initializing notifications: $e');
//       }
//       _isInitialized = false;
//     }
//   }
//
//   static Future<bool> scheduleTripEndNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime endTime,
//   }) async {
//     if (!_isInitialized) {
//       await initialize();
//     }
//
//     if (!await _areNotificationsEnabled()) {
//       if (kDebugMode) {
//         print('Notifications are disabled in settings');
//       }
//       return false;
//     }
//
//     try {
//       await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: id,
//           channelKey: _channelKey,
//           title: title,
//           body: body,
//         ),
//         schedule: NotificationCalendar.fromDate(
//           date: tz.TZDateTime.from(endTime, tz.local),
//           allowWhileIdle: true,
//           preciseAlarm: true,
//         ),
//       );
//       return true;
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error scheduling notification: $e');
//       }
//       return false;
//     }
//   }
//
//   static Future<void> cancelAllScheduledNotifications() async {
//     if (!await _areNotificationsEnabled()) return;
//     await AwesomeNotifications().cancelAllSchedules();
//   }
//
//   static Future<void> cancelNotification(int id) async {
//     if (!await _areNotificationsEnabled()) return;
//     await AwesomeNotifications().cancel(id);
//   }
// }