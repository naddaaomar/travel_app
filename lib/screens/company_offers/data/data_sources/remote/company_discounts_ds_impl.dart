import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'package:p/screens/company_offers/data/data_sources/remote/company_discounts_ds.dart';
import 'package:p/screens/company_profile/data/models/CompanyDetailsModel.dart';
import 'package:p/screens/company_profile/data/models/NewestModel.dart';

@Injectable(as: CompanyDiscountsDs)
class CompanyDiscountsDsImpl implements CompanyDiscountsDs {
  ApiManager apiManager;

  CompanyDiscountsDsImpl(this.apiManager);

  @override
  Future<AllTravelsModel> getDiscounted(
      {required int PageSize,
      required int PageIndex,
      required String companyId,
      String? Sort,
      double? MinPrice,
      double? MaxPrice,
      int? CategorieyId}) async {
    try {
      var response = await apiManager
          .getData(endPoint: Constants.discountedEndPoint, query: {
        "PageSize": "$PageSize",
        "PageIndex": "$PageIndex",
        "Sort": Sort == null
            ? "priceDec"
            : Sort == "Ascending"
                ? "priceAsc"
                : "priceDec",
        if (MinPrice != null) "MinPrice": MinPrice,
        if (MaxPrice != null) "MaxPrice": MaxPrice,
        if (CategorieyId != null) "CategorieyId": CategorieyId,
        "ComapnyId": companyId
      });

      AllTravelsModel discountTravelsModelResponse =
          AllTravelsModel.fromJson(response.data);

      return discountTravelsModelResponse;
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
