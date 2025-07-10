import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import '../../data/models/AllTravelsModel.dart';

abstract class AllTravelsRepo {
  Future<Either<ErrorFailures, AllTravelsModel>> getTravels({
    required int PageIndex,
    required int PageSize,
    String? Sort,
    double?MinPrice,
    double?MaxPrice,
    int? CategorieyId

  });
}