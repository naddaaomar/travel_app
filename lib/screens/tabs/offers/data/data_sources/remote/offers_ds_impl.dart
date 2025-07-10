import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/all_discount_travels/data/remote/models/DiscountItemsModel.dart';

import '../../../../../all_companies/data/models/AllCompaniesModel.dart';
import 'offers_ds.dart';

@Injectable(as: OffersDs)
class OffersDsImpl implements OffersDs {
  ApiManager apiManager;

  OffersDsImpl(this.apiManager);

  @override
  Future<AllCompaniesModel> getCompanies(
      {required int PageSize, required int PageIndex,
        String? sort,
        int? rate}) async {
    try {
      var response = await apiManager.getData(
          endPoint: Constants.companiesEndPoint,
          query: {"PageSize": "$PageSize", "PageIndex": "$PageIndex",
            "sort": sort == null?"priceDec":sort=="Ascending"?"rateAsc":"rateDec",
            if (rate != null) "rate": "$rate",});

      AllCompaniesModel allCompaniesModelResponse =
          AllCompaniesModel.fromJson(response.data);

      return allCompaniesModelResponse;
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

  @override
  Future<DiscountItemsModel> getDiscount(
      {required int PageSize, required int PageIndex})async {
    try {
      var response = await apiManager.getData(
          endPoint: "${Constants.travelsEndPoint}/discounted",
          query: {
            "PageSize":"$PageSize",
            "PageIndex":"$PageIndex"
          }
      );

      DiscountItemsModel discountTravelsModel =
      DiscountItemsModel.fromJson(response.data);

      print("remoteeeeee");
      return discountTravelsModel;
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
