import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/all_discount_travels/data/remote/models/AllDiscountModel.dart';

abstract class AllDiscountsRepo {
  Future<Either<ErrorFailures, AllDiscountModel>> getDiscounts({
    required int PageIndex,
    required int PageSize,
    String? Sort,
    double?MinPrice,
    double?MaxPrice,
    int? CategorieyId

  });
}