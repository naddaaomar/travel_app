import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import '../../models/AllCompaniesModel.dart';
import 'all_companies_ds.dart';

@Injectable(as: AllCompaniesDs)
class AllCompaniesDsImpl implements AllCompaniesDs {
  ApiManager apiManager;

  AllCompaniesDsImpl(this.apiManager);

  @override
  Future<AllCompaniesModel> getCompanies(
      {required int PageSize,
        required int PageIndex,
        String? sort,
        int? rate}) async {
    try {
      var response = await apiManager
          .getData(endPoint: Constants.companiesEndPoint, query: {
        "PageSize": "$PageSize",
        "PageIndex": "$PageIndex",
        "sort": sort == null?"priceDec":sort=="Ascending"?"rateAsc":"rateDec",
        if (rate != null) "rate": "$rate",


      });

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
}