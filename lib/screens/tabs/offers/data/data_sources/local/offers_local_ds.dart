import 'package:p/screens/all_companies/data/models/AllCompaniesModel.dart';
import 'package:p/screens/tabs/offers/data/models/DiscountTravelsModel.dart';

abstract class OffersLocalDs {
  Future<void> cacheCompanies(AllCompaniesModel companies);
  Future<AllCompaniesModel?> getCachedCompanies();

  Future<void> cacheDiscounts(DiscountTravelsModel discounts);
  Future<DiscountTravelsModel?> getCachedDiscounts();
}
