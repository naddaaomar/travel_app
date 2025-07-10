import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/all_discount_travels/data/remote/models/AllDiscountModel.dart';
import 'package:p/screens/all_discount_travels/domain/repositories/all_discounts_repo.dart';

@injectable
class AllDiscountsUseCase {
  AllDiscountsRepo allDiscountsRepo;

  AllDiscountsUseCase(this.allDiscountsRepo);

  Future<Either<ErrorFailures, AllDiscountModel>> call(
      {required int PageIndex,
        required int PageSize,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) =>
      allDiscountsRepo.getDiscounts(
          PageIndex: PageIndex,
          PageSize: PageSize,
          Sort: Sort,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          CategorieyId: CategorieyId);
}