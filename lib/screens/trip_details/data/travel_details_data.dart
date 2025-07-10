import 'package:dio/dio.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/screens/trip_details/models/TravelDetailsModel.dart';

class TravelDetailsData {
  Dio dio = Dio();

  getTravelDetails({required String id}) async {
    try {
      var response = await dio.get("${Constants.baseURL}/api/Travel/$id");
      TravelDetailsModel travelDetailsModel = TravelDetailsModel.fromJson(response.data);
      print(response.data);
      return travelDetailsModel;
    } on DioException catch (e) {
      if (e.response == null) {
        print("nulllllllllll");
      }
      print(e.error);
    }
  }
}