import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'package:p/screens/company_profile/data/models/CompanyDetailsModel.dart';
import 'package:p/screens/company_profile/data/models/NewestModel.dart';

abstract class CompanyDetailsRepo {
  Future<Either<ErrorFailures, CompanyDetailsModel>> getDetails(
      {required String id});
  Future<Either<ErrorFailures, AllTravelsModel>> getTravels(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId});
  Future<Either<ErrorFailures, AllTravelsModel>> getDiscounted(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId});
  Future<Either<ErrorFailures, AllTravelsModel>> getLeavingSoon(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId});
  Future<Either<ErrorFailures, NewestModel>> getNewest(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId});

}