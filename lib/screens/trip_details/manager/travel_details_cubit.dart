import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:p/helpers/internet_checker/internet_checker.dart';
import 'package:p/main.dart';
import 'package:p/screens/trip_details/data/travel_details_data.dart';
import 'package:p/screens/trip_details/models/TravelDetailsModel.dart';

part 'travel_details_state.dart';

class TravelDetailsCubit extends Cubit<TravelDetailsState> {
  final TravelDetailsData data = TravelDetailsData();
  final NetworkInfo networkInfo;
  TravelDetailsCubit({
    required this.networkInfo

  }) : super(const TravelDetailsState());

  static TravelDetailsCubit get(context) => BlocProvider.of(context);

  getTravelDetails({required String id}) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        print("diiiissssssssssss");
        showNoInternetSnackBar(); // 👈 show the global snackbar
        emit(state.copyWith(
          isLoading: false,
          error: 'No internet connection. Please try again.',
        ));
        return;
      }

      final travelDetailsModel = await data.getTravelDetails(id: id);

      emit(state.copyWith(
        isLoading: false,
        travelDetailsModel: travelDetailsModel,
        error: null,
      ));
      print("dataa arriveddddddddddddddddddddddddddd");
      return travelDetailsModel;
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load travel details',
      ));
    }
  }


  bool isDescriptionExpanded = false;

  void toggleDescriptionExpanded() {
    isDescriptionExpanded = !isDescriptionExpanded;
    emit(state.copyWith());
  }
}
