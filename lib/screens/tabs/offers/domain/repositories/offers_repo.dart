import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/tabs/offers/data/models/DiscountTravelsModel.dart';

import '../../../../all_companies/data/models/AllCompaniesModel.dart';

abstract class OffersRepo {
  Future<Either<ErrorFailures, AllCompaniesModel>> getCompanies({
    required int PageIndex,
    required int PageSize,
    String? sort,
    int? rate
  });
  Future<Either<ErrorFailures, DiscountTravelsModel>> getDiscounts({
    required int PageIndex,
    required int PageSize,
  });
}
