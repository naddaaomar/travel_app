import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'package:p/screens/newest_view_all/data/remote/data_sources/all_newest_ds.dart';
import 'package:p/screens/newest_view_all/data/remote/models/AllNewestModel.dart';


@Injectable(as: AllNewestDs)
class AllNewestDsImpl implements AllNewestDs {
  ApiManager apiManager;

  AllNewestDsImpl(this.apiManager);

  @override
  Future<AllNewestModel> getNewest(
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
          endPoint: Constants.newestEndPoint,
          query: {
            "PageSize": "$PageSize",
            "PageIndex": "$PageIndex",
            "Sort": Sort == null?"priceDec":Sort=="Ascending"?"priceAsc":"priceDec",
            if (MinPrice != null) "MinPrice": MinPrice,
            if (MaxPrice != null) "MaxPrice": MaxPrice,
            if (CategorieyId != null) "CategorieyId": CategorieyId,

          });

      AllNewestModel allNewestModel =
      AllNewestModel.fromJson(response.data);

      return allNewestModel;
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