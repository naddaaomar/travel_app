import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'package:p/screens/company_profile/data/models/CompanyDetailsModel.dart';
import 'package:p/screens/company_profile/data/models/NewestModel.dart';

abstract class CompanyDetailsDs {
  Future<CompanyDetailsModel> getDetails({required String id});
  Future<AllTravelsModel> getTravels(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId});

  Future<AllTravelsModel> getDiscounted(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId});
  Future<AllTravelsModel> getLeavingSoon(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId});
  Future<NewestModel> getNewest(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId});

}
