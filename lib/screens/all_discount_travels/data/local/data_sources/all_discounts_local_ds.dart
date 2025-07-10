import 'package:p/screens/all_discount_travels/data/remote/models/AllDiscountModel.dart';

abstract class AllDiscountsLocalDs {
  Future<void> cacheDiscounts(AllDiscountModel discounts);
  Future<AllDiscountModel?> getCachedDiscounts();
}