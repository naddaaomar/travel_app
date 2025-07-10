import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/helpers/internet_checker/internet_checker.dart';
import 'package:p/screens/all_companies/data/models/AllCompaniesModel.dart';
import 'package:p/screens/tabs/offers/data/data_sources/local/offers_local_ds.dart';
import 'package:p/screens/tabs/offers/data/models/DiscountTravelsModel.dart';
import '../../domain/repositories/offers_repo.dart';
import '../data_sources/remote/offers_ds.dart';

@Injectable(as: OffersRepo)
class OffersRepoImpl implements OffersRepo {
  final OffersDs offersDs;
  final OffersLocalDs offersLocalDs;

  final NetworkInfo networkInfo;

  OffersRepoImpl(
      this.offersDs,
      this.offersLocalDs,

      this.networkInfo,
      );

  @override
  Future<Either<ErrorFailures, AllCompaniesModel>> getCompanies({
    required int PageIndex,
    required int PageSize,
    String? sort,
    int? rate,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final data = await offersDs.getCompanies(
          PageSize: PageSize,
          PageIndex: PageIndex,
          rate: rate,
          sort: sort,
        );
        await offersLocalDs.cacheCompanies(data);
        return Right(data);
      } else {
        final cached = await offersLocalDs.getCachedCompanies();
        if (cached != null) {
          return Right(cached);
        } else {
          return Left(ErrorLocalFailure("No internet and no cached companies"));
        }
      }
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<ErrorFailures, DiscountTravelsModel>> getDiscounts({
    required int PageIndex,
    required int PageSize,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final data =
        await offersDs.getDiscount(PageSize: PageSize, PageIndex: PageIndex);
        await offersLocalDs.cacheDiscounts(data);
        return Right(data);
      } else {
        final cached = await offersLocalDs.getCachedDiscounts();
        if (cached != null) {
          return Right(cached);
        } else {
          return Left(ErrorLocalFailure("No internet and no cached discounts"));
        }
      }
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}