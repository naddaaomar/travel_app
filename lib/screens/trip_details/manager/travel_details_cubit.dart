import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/trip_details/data/travel_details_data.dart';
import 'package:p/screens/trip_details/models/TravelDetailsModel.dart';

part 'travel_details_state.dart';

class TravelDetailsCubit extends Cubit<TravelDetailsState> {
  TravelDetailsCubit() : super(TravelDetailsInitial());

  TravelDetailsData data = TravelDetailsData();
  static TravelDetailsCubit get(context)=>BlocProvider.of(context);
  getTravelDetails({required String id}) async {
    try {
      emit(TravelDetailsLoading());
      TravelDetailsModel travelDetailsModel =
      await data.getTravelDetails(id: id);
      emit(TravelDetailsSuccess(travelDetailsModel));
    } catch (e) {
      print(e.toString());
      emit(TravelDetailsError());
    }
  }
}