import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/exceptions/exceptions.dart';

import '../model/rating_model.dart';
import 'rating_ds.dart';

@Injectable(as: CompanyRatingDs)
class CompanyRatingDsImpl implements CompanyRatingDs {
  final ApiManager apiManager;

  CompanyRatingDsImpl(this.apiManager);

  @override
  Future<void> submitRating(CompanyRatingModel rating) async {
    try {
      await apiManager.postDate(
        endPoint: Constants.companyRatingsEndpoint,
        data: rating.toJson(),
      );
    } on DioException catch (e) {
      print('Error submitting rating: ${e.message}');
      throw ErrorRemoteException(e.toString());
    }
  }

  @override
  Future<List<CompanyRatingModel>> getCompanyRatings(int companyId) async {
    try {
      final response = await apiManager.getData(
        endPoint: '${Constants.companyRatingsEndpoint}/$companyId',
      );

      return (response.data as List)
          .map((json) => CompanyRatingModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      print('Error getting company ratings: ${e.message}');
      throw ErrorRemoteException(e.toString());
    }
  }
}