import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/all_travels/data/all_travels_data.dart';
import 'package:p/screens/all_travels/models/AllTravelsModel.dart';

part 'all_travels_state.dart';

class AllTravelsCubit extends Cubit<AllTravelsState> {
  AllTravelsCubit() : super(AllTravelsInitial());
  AllTravelsData data = AllTravelsData();

  getAllTravels() async {
    try {
      emit(AllTravelsLoading());
      var response = await data.getAllTravels();
      print(response);
      emit(AllTravelsSuccess(response));
    } catch (e) {
      print(e.toString());
      emit(AllTravelsError());
    }
  }
}
