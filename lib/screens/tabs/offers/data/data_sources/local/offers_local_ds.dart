import 'package:p/screens/all_companies/data/models/AllCompaniesModel.dart';
import 'package:p/screens/all_discount_travels/data/remote/models/DiscountItemsModel.dart';

abstract class OffersLocalDs {
  Future<void> cacheCompanies(AllCompaniesModel companies);
  Future<AllCompaniesModel?> getCachedCompanies();

  Future<void> cacheDiscounts(DiscountItemsModel discounts);
  Future<DiscountItemsModel?> getCachedDiscounts();
}
