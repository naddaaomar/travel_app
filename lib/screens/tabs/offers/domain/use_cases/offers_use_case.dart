import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/all_discount_travels/data/remote/models/DiscountItemsModel.dart';
import 'package:p/screens/tabs/offers/domain/repositories/offers_repo.dart';

import '../../../../all_companies/data/models/AllCompaniesModel.dart';


@injectable
class OffersUseCase {
  OffersRepo offersRepo;

  OffersUseCase(this.offersRepo);

  Future<Either<ErrorFailures, AllCompaniesModel>> callCompanies({
    required int PageIndex,
    required int PageSize,
    String? sort,
    int? rate
  }) =>
      offersRepo.getCompanies(PageIndex: PageIndex, PageSize: PageSize,sort: sort,rate: rate);

  Future<Either<ErrorFailures, DiscountItemsModel>> callDiscount({
    required int PageIndex,
    required int PageSize,
  }) =>
      offersRepo.getDiscounts(PageIndex: PageIndex, PageSize: PageSize);
}
