import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';

abstract class CompanyDiscountsRepo {
  Future<Either<ErrorFailures, AllTravelsModel>> getDiscounted(
      {required int PageSize,
      required int PageIndex,
      required String companyId,
      String? Sort,
      double? MinPrice,
      double? MaxPrice,
      int? CategorieyId});
}
