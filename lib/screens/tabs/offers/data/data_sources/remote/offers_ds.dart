import 'package:p/screens/tabs/offers/data/models/DiscountTravelsModel.dart';
import '../../../../../all_companies/data/models/AllCompaniesModel.dart';

abstract class OffersDs {
  Future<AllCompaniesModel> getCompanies({
    required int PageSize,
    required int PageIndex,
    String? sort,
    int? rate
  });
  Future<DiscountTravelsModel> getDiscount({
    required int PageSize,
    required int PageIndex,
  });
}