import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'package:p/screens/company_profile/data/data_sources/remote/company_details_ds.dart';
import 'package:p/screens/company_profile/data/models/CompanyDetailsModel.dart';
import 'package:p/screens/company_profile/data/models/NewestModel.dart';
import 'package:p/screens/company_profile/domain/repositories/company_details_repo.dart';

@Injectable(as: CompanyDetailsRepo)
class CompanyDetailsRepoImpl implements CompanyDetailsRepo {
  CompanyDetailsDs companyDetailsDs;
  CompanyDetailsRepoImpl(this.companyDetailsDs);

  @override
  Future<Either<ErrorFailures, CompanyDetailsModel>> getDetails(
      {required String id}) async {
    try {
      var data = await companyDetailsDs.getDetails(id: id);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, AllTravelsModel>> getDiscounted(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) async {
    try {
      var data = await companyDetailsDs.getDiscounted(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, AllTravelsModel>> getLeavingSoon(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) async {
    try {
      var data = await companyDetailsDs.getLeavingSoon(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, NewestModel>> getNewest(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) async {
    try {
      var data = await companyDetailsDs.getNewest(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, AllTravelsModel>> getTravels(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) async {
    try {
      var data = await companyDetailsDs.getTravels(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}