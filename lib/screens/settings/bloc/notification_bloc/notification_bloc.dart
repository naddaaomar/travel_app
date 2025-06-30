import 'package:bloc/bloc.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<LoadNotificationPreference>(_onLoadNotificationPreference);
    on<ToggleNotification>(_onToggleNotification);

    add(LoadNotificationPreference());
  }

  Future<void> _onLoadNotificationPreference(
      LoadNotificationPreference event,
      Emitter<NotificationState> emit,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool('notifications_enabled') ?? true;
    emit(NotificationLoaded(isEnabled: isEnabled));
  }

  Future<void> _onToggleNotification(
      ToggleNotification event,
      Emitter<NotificationState> emit,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', event.isEnabled);

    if (event.isEnabled) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }

    emit(NotificationLoaded(isEnabled: event.isEnabled));
  }
}