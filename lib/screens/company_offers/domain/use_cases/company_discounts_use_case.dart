import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'package:p/screens/company_offers/domain/repositories/company_discounts_repo.dart';

@injectable
class CompanyDiscountsUseCase {
  CompanyDiscountsRepo companyDiscountsRepo;

  CompanyDiscountsUseCase(this.companyDiscountsRepo);

  Future<Either<ErrorFailures, AllTravelsModel>> callDiscount(
      {required int PageSize,
        required int PageIndex,
        required String companyId,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) =>
      companyDiscountsRepo.getDiscounted(
          companyId: companyId,
          PageIndex: PageIndex,
          PageSize: PageSize,
          CategorieyId: CategorieyId,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          Sort: Sort);
}