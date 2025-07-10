import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/all_discount_travels/data/remote/data_sources/all_discounts_ds.dart';
import 'package:p/screens/all_discount_travels/data/remote/models/AllDiscountModel.dart';
import 'package:p/screens/all_discount_travels/domain/repositories/all_discounts_repo.dart';
import '../../../../helpers/internet_checker/internet_checker.dart';
import '../local/data_sources/all_discounts_local_ds.dart';

@Injectable(as: AllDiscountsRepo)
class AllDiscountsRepoImpl implements AllDiscountsRepo {
  final AllDiscountsDs remoteDs;
  final AllDiscountsLocalDs localDs;
  final NetworkInfo networkInfo;

  AllDiscountsRepoImpl(this.remoteDs, this.localDs, this.networkInfo);

  @override
  Future<Either<ErrorFailures, AllDiscountModel>> getDiscounts({
    required int PageIndex,
    required int PageSize,
    String? Sort,
    double? MinPrice,
    double? MaxPrice,
    int? CategorieyId,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final data = await remoteDs.getDiscounts(
          PageSize: PageSize,
          PageIndex: PageIndex,
          Sort: Sort,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          CategorieyId: CategorieyId,
        );

        await localDs.cacheDiscounts(data);
        print("✅ Discounts cached");
        return Right(data);
      } else {
        final cached = await localDs.getCachedDiscounts();
        if (cached != null) {
          print("📦 Using cached discounts");
          return Right(cached);
        } else {
          return Left(ErrorLocalFailure('No internet and no cached discounts'));
        }
      }
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}