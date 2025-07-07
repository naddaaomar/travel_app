import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'package:p/screens/company_offers/data/data_sources/remote/company_discounts_ds.dart';
import 'package:p/screens/company_offers/domain/repositories/company_discounts_repo.dart';

@Injectable(as: CompanyDiscountsRepo)
class CompanyDiscountsRepoImpl implements CompanyDiscountsRepo {
  CompanyDiscountsDs companyDiscountsDs;
  CompanyDiscountsRepoImpl(this.companyDiscountsDs);

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
      var data = await companyDiscountsDs.getDiscounted(
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
