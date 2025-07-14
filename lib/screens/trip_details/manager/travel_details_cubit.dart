import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/trip_details/data/travel_details_data.dart';
import 'package:p/screens/trip_details/models/TravelDetailsModel.dart';

part 'travel_details_state.dart';

class TravelDetailsCubit extends Cubit<TravelDetailsState> {
  TravelDetailsCubit() : super(const TravelDetailsState());

  static TravelDetailsCubit get(context) => BlocProvider.of(context);

  final TravelDetailsData data = TravelDetailsData();

 getTravelDetails({required String id}) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final travelDetailsModel = await data.getTravelDetails(id: id);

      emit(state.copyWith(
        isLoading: false,
        travelDetailsModel: travelDetailsModel,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load travel details',
      ));
    }
  }
}
