import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/newest_view_all/data/remote/models/AllNewestModel.dart';

abstract class AllNewestRepo {
  Future<Either<ErrorFailures, AllNewestModel>> getNewest({
    required int PageIndex,
    required int PageSize,
    String? Sort,
    double?MinPrice,
    double?MaxPrice,
    int? CategorieyId

  });
}
