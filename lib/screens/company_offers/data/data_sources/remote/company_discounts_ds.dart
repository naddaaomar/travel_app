import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';

abstract class CompanyDiscountsDs {
  Future<AllTravelsModel> getDiscounted(
      {required int PageSize,
      required int PageIndex,
      required String companyId,
      String? Sort,
      double? MinPrice,
      double? MaxPrice,
      int? CategorieyId});
}
