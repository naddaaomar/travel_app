import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/event_details/data/models/EventDetailsModel.dart';
import 'package:p/screens/event_details/domain/use_cases/event_details_use_case.dart';

part 'event_details_state.dart';
@injectable
class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit(this.eventDetailsUseCase) : super(EventDetailsState());
  final EventDetailsUseCase eventDetailsUseCase;

  static EventDetailsCubit get(context) => BlocProvider.of(context);

  Future<void> getDetails({required String id}) async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      final response = await eventDetailsUseCase.callDetails(id: id);
      response.fold(
            (failure) => emit(state.copyWith(isLoading: false, hasError: true)),
            (data) => emit(state.copyWith(
          isLoading: false,
          hasError: false,
          detailsModel: data,
        )),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }

  void toggleDescriptionExpansion() {
    emit(state.copyWith(
      isDescriptionExpanded: !state.isDescriptionExpanded,
    ));
  }
}