import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'package:p/screens/company_profile/data/models/CompanyDetailsModel.dart';
import 'package:p/screens/company_profile/data/models/NewestModel.dart';
import 'package:p/screens/company_profile/domain/repositories/company_details_repo.dart';

@injectable
class CompanyDetailsUseCase {
  CompanyDetailsRepo companyDetailsRepo;

  CompanyDetailsUseCase(this.companyDetailsRepo);

  Future<Either<ErrorFailures, CompanyDetailsModel>> callDetails(
      {required String id}) =>
      companyDetailsRepo.getDetails(id: id);

  Future<Either<ErrorFailures, AllTravelsModel>> callTravels(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) =>
      companyDetailsRepo.getTravels(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);

  Future<Either<ErrorFailures, AllTravelsModel>> callDiscount(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) =>
      companyDetailsRepo.getDiscounted(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);

  Future<Either<ErrorFailures, NewestModel>> callNewest(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) =>
      companyDetailsRepo.getNewest(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);

  Future<Either<ErrorFailures, AllTravelsModel>> callLeavingSoon(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) =>
      companyDetailsRepo.getLeavingSoon(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);
}