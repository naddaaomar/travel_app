import '../../models/AllTravelsModel.dart';

abstract class AllTravelsDs {
  Future<AllTravelsModel> getTravels(
      {required int PageSize,
      required int PageIndex,
      String? Sort,
      double? MinPrice,
      double? MaxPrice,
      int? CategorieyId});
}
