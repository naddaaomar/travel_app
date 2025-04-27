import 'package:dio/dio.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/screens/all_companies/models/AllCompanies.dart';

class Data {
  Dio dio = Dio();

  getAllCompanies() async {
    try {
      var response =
          await dio.get("${Constants.baseURL}/api/Company");
      AllCompaniesModel allCompanies = AllCompaniesModel.fromJson(response.data);
      print(allCompanies.items);
      return allCompanies;
    } on DioException catch (e){
      if (e.response==null){
        print("nulllllllllll");

      }
      print(e.error);
    }
  }
}
