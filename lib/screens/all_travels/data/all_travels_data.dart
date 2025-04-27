import 'package:dio/dio.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/screens/all_travels/models/AllTravelsModel.dart';

class AllTravelsData {
  Dio dio = Dio();

  getAllTravels() async {
    try {
      var response = await dio.get("${Constants.baseURL}/api/Travel");
      AllTravelsModel allTravelsModel = AllTravelsModel.fromJson(response.data);
      print(response.data);
      return allTravelsModel;
    } on DioException catch (e) {
      if (e.response == null) {
        print("nulllllllllll");
      }
      print(e.error);
    }
  }
}
