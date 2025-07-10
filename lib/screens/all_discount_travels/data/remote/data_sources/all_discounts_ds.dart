import 'package:p/screens/all_discount_travels/data/remote/models/DiscountItemsModel.dart';

abstract class AllDiscountsDs {
  Future<DiscountItemsModel> getDiscounts(
      {required int PageSize,
      required int PageIndex,
      String? Sort,
      double? MinPrice,
      double? MaxPrice,
      int? CategorieyId});
}
