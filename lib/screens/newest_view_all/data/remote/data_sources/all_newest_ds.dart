import 'package:p/screens/newest_view_all/data/remote/models/AllNewestModel.dart';

abstract class AllNewestDs {
  Future<AllNewestModel> getNewest(
      {required int PageSize,
      required int PageIndex,
      String? Sort,
      double? MinPrice,
      double? MaxPrice,
      int? CategorieyId});
}
