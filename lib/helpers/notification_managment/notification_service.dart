import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../themes/colors.dart';

class NotificationService {
  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      null, // Use default app icon
      [
        NotificationChannel(
          channelKey: 'journey_mate_channel',
          channelName: 'Journey Mate Notifications',
          channelDescription: 'Notifications for trip updates',
          importance: NotificationImportance.High,
          defaultColor: ColorApp.thirdColor,
          ledColor: Colors.white,
          playSound: true,
          enableVibration: true,
        )
      ],
    );

    await AwesomeNotifications().requestPermissionToSendNotifications();

    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    await AwesomeNotifications().setChannel(NotificationChannel(
      channelKey: 'journey_mate_channel',
      channelName: 'Journey Mate',
      importance: NotificationImportance.High,
      playSound: true,
      channelDescription: '',
    ));
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
        channelKey: 'journey_mate_channel',
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

  /*
  <<TEST>>
  static Future<void> scheduleTestNotification() async {
    final now = DateTime.now();
    final tenSecondsLater = now.add(Duration(seconds: 10));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1000,
        channelKey: 'journey_mate_channel',
        title: 'TEST: Scheduled Trip',
        body: 'This notification was scheduled 10 seconds ago!',
        notificationLayout: NotificationLayout.Default,
        displayOnForeground: true,
        displayOnBackground: true,
      ),
      schedule: NotificationCalendar.fromDate(
        date: tenSecondsLater,
        allowWhileIdle: true,
      ),
    );
  }
  */