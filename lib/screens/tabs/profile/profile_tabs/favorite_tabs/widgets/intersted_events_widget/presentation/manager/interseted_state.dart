/*
import '../../data/model/interseted_event_model.dart';

sealed class InterestedEventsState {
  const InterestedEventsState();
}

class InterestedEventsInitial extends InterestedEventsState {
  const InterestedEventsInitial();
}

class InterestedEventsLoading extends InterestedEventsState {
  const InterestedEventsLoading();
}

class InterestedEventsLoaded extends InterestedEventsState {
  final List<InterstedEvents> events;
  const InterestedEventsLoaded(this.events);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is InterestedEventsLoaded &&
              runtimeType == other.runtimeType &&
              events == other.events;

  @override
  int get hashCode => events.hashCode;
}

class InterestedEventsError extends InterestedEventsState {
  final String message;
  final int? statusCode;

  const InterestedEventsError(this.message, [this.statusCode]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is InterestedEventsError &&
              runtimeType == other.runtimeType &&
              message == other.message &&
              statusCode == other.statusCode;

  @override
  int get hashCode => Object.hash(message, statusCode);
}

class InterestedEventsAuthRequired extends InterestedEventsState {
  const InterestedEventsAuthRequired();
}

 */