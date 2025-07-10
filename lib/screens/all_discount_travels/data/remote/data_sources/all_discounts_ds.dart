import 'package:p/screens/all_discount_travels/data/remote/models/AllDiscountModel.dart';

abstract class AllDiscountsDs {
  Future<AllDiscountModel> getDiscounts(
      {required int PageSize,
        required int PageIndex,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId});
}