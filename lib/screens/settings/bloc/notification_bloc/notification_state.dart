part of 'notification_bloc.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final bool isEnabled;
  NotificationLoaded({required this.isEnabled});
}