import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'package:p/screens/company_profile/data/data_sources/remote/company_details_ds.dart';
import 'package:p/screens/company_profile/data/models/CompanyDetailsModel.dart';
import 'package:p/screens/company_profile/data/models/NewestModel.dart';

@Injectable(as: CompanyDetailsDs)
class CompanyDetailsDsImpl implements CompanyDetailsDs {
  ApiManager apiManager;

  CompanyDetailsDsImpl(this.apiManager);

  @override
  Future<CompanyDetailsModel> getDetails({required String id}) async {
    try {
      var response = await apiManager.getData(
        endPoint: "${Constants.companiesEndPoint}/$id",
      );

      CompanyDetailsModel companyDetailsModel =
          CompanyDetailsModel.fromJson(response.data);

      return companyDetailsModel;
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

  @override
  Future<AllTravelsModel> getLeavingSoon(
      {required int PageSize,
      required int PageIndex,
      required String companyId,
      String? Sort,
      double? MinPrice,
      double? MaxPrice,
      int? CategorieyId}) async {
    try {
      var response = await apiManager
          .getData(endPoint: Constants.leavingSoonEndPoint, query: {
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

      AllTravelsModel leavingSoonTravelsModelResponse =
          AllTravelsModel.fromJson(response.data);

      return leavingSoonTravelsModelResponse;
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
  Future<NewestModel> getNewest(
      {required int PageSize,
      required int PageIndex,
      required String companyId,
      String? Sort,
      double? MinPrice,
      double? MaxPrice,
      int? CategorieyId}) async {
    try {
      var response = await apiManager.getData(
          endPoint: "${Constants.newestCompanyEndPoint}/$companyId",
          query: {
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
          });

      NewestModel newestTravelsModelResponse =
          NewestModel.fromJson(response.data);

      return newestTravelsModelResponse;
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
  Future<AllTravelsModel> getTravels(
      {required int PageSize,
      required int PageIndex,
      required String companyId,
      String? Sort,
      double? MinPrice,
      double? MaxPrice,
      int? CategorieyId}) async {
    try {
      var response =
          await apiManager.getData(endPoint: Constants.travelsEndPoint, query: {
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
