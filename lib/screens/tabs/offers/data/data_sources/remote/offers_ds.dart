
import 'package:p/screens/all_discount_travels/data/remote/models/DiscountItemsModel.dart';

import '../../../../../all_companies/data/models/AllCompaniesModel.dart';

abstract class OffersDs {
  Future<AllCompaniesModel> getCompanies({
    required int PageSize,
    required int PageIndex,
    String? sort,
    int? rate
  });
  Future<DiscountItemsModel> getDiscount({
    required int PageSize,
    required int PageIndex,
  });
}
