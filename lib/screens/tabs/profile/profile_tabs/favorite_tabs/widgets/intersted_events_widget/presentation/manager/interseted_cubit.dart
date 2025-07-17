import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../data/model/interseted_event_model.dart';
import '../../data/service/interested_events_service.dart';
import 'interseted_state.dart';

class InterestedEventsCubit extends Cubit<InterestedEventsState> {
  final InterestedEventsService _service;

  InterestedEventsCubit({required http.Client client})
      : _service = InterestedEventsService(client: client),
        super(InterestedEventsInitial()) {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await fetchInterestedEvents();
  }

  Future<void> fetchInterestedEvents() async {
    emit(InterestedEventsLoading());
    try {
      final events = await _service.getInterestedEvents();
      emit(InterestedEventsLoaded(events));
    } on InterestedEventsException catch (e) {
      if (e.statusCode == 401) {
        emit(InterestedEventsAuthRequired());
      } else {
        emit(InterestedEventsError(e.message, e.statusCode));
      }
    } catch (e) {
      emit(InterestedEventsError('Failed to load events: ${e.toString()}'));
    }
  }

  Future<void> toggleInterest(InterstedEvents event) async {
    final currentState = state;

    if (currentState is! InterestedEventsLoaded) return;

    final updatedEvents = currentState.events.where((e) => e.id != event.id).toList();
    emit(InterestedEventsLoaded(updatedEvents));

    try {
      final success = await _service.toggleInterest(event.id);

      if (!success) {
        emit(InterestedEventsError('Failed to update interest on server.'));
        emit(InterestedEventsLoaded(currentState.events));
      }

    } on InterestedEventsException catch (e) {
      emit(InterestedEventsError(e.message, e.statusCode));
      emit(InterestedEventsLoaded(currentState.events));
    } catch (e) {
      emit(InterestedEventsError('Failed to toggle interest: ${e.toString()}'));
      emit(InterestedEventsLoaded(currentState.events));
    }
  }

  Future<void> clearAllInterests() async {
    emit(InterestedEventsLoading());
    try {
      await _service.clearAllInterests();
      emit(InterestedEventsLoaded([]));
    } on InterestedEventsException catch (e) {
      emit(InterestedEventsError(e.message, e.statusCode));
    } catch (e) {
      emit(InterestedEventsError('Failed to clear interests: ${e.toString()}'));
    }
  }
}