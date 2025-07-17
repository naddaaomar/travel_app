
import 'package:p/screens/all_discount_travels/data/remote/models/DiscountItemsModel.dart';


abstract class AllDiscountsLocalDs {
  Future<void> cacheDiscounts(DiscountItemsModel discounts);
  Future<DiscountItemsModel?> getCachedDiscounts();
}

