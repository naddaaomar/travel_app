import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:p/helpers/notification_managment/notification_service.dart';

Future<void> scheduleNotificationForTrip(String tripId) async {
  try {
    final response = await http.get(
      Uri.parse('https://journeymate.runasp.net/api/Trip/$tripId'),
      headers: {'Accept': 'application/json'},
    );  // Fetch trip details from API

    if (response.statusCode == 200) {
      final tripData = json.decode(response.body);
      final endTime = DateTime.parse(tripData['endTime']);

      await NotificationService.scheduleTripEndNotification(
        id: UniqueKey().hashCode,
        title: 'Trip Completed!',
        body: 'Your journey to ${tripData['destination']} has ended ,Would you like to rate ?',
        endTime: endTime,
      );  // Schedule notification
    }
  } catch (e) {
    print('Error scheduling notification: $e');
  }
}