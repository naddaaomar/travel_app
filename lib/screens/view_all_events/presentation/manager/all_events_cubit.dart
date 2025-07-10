import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/view_all_events/domain/use_cases/all_events_use_case.dart';

part 'all_events_state.dart';
@injectable
class AllEventsCubit extends Cubit<AllEventsState> {
  AllEventsCubit(this.allEventsUseCase) : super(AllEventsState());
  AllEventsUseCase allEventsUseCase;
  static AllEventsCubit get(context) => BlocProvider.of(context);

  Future<void> getEvents() async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      final response = await allEventsUseCase.callEvents();

      response.fold(
            (failure) => emit(state.copyWith(isLoading: false, hasError: true)),
            (data) => emit(state.copyWith(
          isLoading: false,
          hasError: false,
          eventsModel: data,
        )),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }

}
