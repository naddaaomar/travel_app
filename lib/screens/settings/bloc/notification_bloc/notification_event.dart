part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class LoadNotificationPreference extends NotificationEvent {}

class ToggleNotification extends NotificationEvent {
  final bool isEnabled;
  ToggleNotification(this.isEnabled);
}