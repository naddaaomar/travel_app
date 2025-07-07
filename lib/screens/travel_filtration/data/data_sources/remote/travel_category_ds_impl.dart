import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/travel_filtration/data/data_sources/remote/travel_category_ds.dart';
import 'package:p/screens/travel_filtration/data/models/CategoryModel.dart';

@Injectable(as: TravelCategoryDs)
class TravelCategoryDsImpl implements TravelCategoryDs {
  ApiManager apiManager;

  TravelCategoryDsImpl(this.apiManager);
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await apiManager.getData(endPoint: Constants.categoryEndPoint);
      List data = response.data;
      List<CategoryModel> categories = data.map((e) => CategoryModel.fromJson(e)).toList();

      return categories;
    } on DioException catch (e) {
      print('DioException caught!');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      print('Response: ${e.response}');
      print('Status Code: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');
      print('Request Path: ${e.requestOptions.path}');

      throw ErrorRemoteException(e.toString());
    }
  }

}
