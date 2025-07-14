import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/all_discount_travels/data/remote/models/DiscountItemsModel.dart';

abstract class AllDiscountsRepo {
  Future<Either<ErrorFailures, DiscountItemsModel>> getDiscounts({
    required int PageIndex,
    required int PageSize,
    String? Sort,
    double?MinPrice,
    double?MaxPrice,
    int? CategorieyId

  });
}