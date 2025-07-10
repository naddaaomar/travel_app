import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';

import 'all_travels_ds.dart';

@Injectable(as: AllTravelsDs)
class AllTravelsDsImpl implements AllTravelsDs {
  ApiManager apiManager;

  AllTravelsDsImpl(this.apiManager);

  @override
  Future<AllTravelsModel> getTravels(
      {
        required int PageSize,
        required int PageIndex,
        String? Sort,
        double?MinPrice,
        double?MaxPrice,
        int? CategorieyId

      }
      ) async {
    try {
      var response = await apiManager.getData(
          endPoint: Constants.travelsEndPoint,
          query: {
            "PageSize": "$PageSize",
            "PageIndex": "$PageIndex",
            "Sort": Sort == null?"priceDec":Sort=="Ascending"?"priceAsc":"priceDec",
            if (MinPrice != null) "MinPrice": MinPrice,
            if (MaxPrice != null) "MaxPrice": MaxPrice,
            if (CategorieyId != null) "CategorieyId": CategorieyId,

          });

      AllTravelsModel allTravelsModelResponse =
      AllTravelsModel.fromJson(response.data);

      return allTravelsModelResponse;
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