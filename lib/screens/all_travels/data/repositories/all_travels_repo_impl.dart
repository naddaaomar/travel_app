import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/all_travels/data/data_sources/local/all_travels_local_ds.dart';
import 'package:p/screens/all_travels/data/data_sources/remote/all_travels_ds.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';

import '../../../../helpers/internet_checker/internet_checker.dart';
import '../../domain/repositories/all_travels_repo.dart';

@Injectable(as: AllTravelsRepo)
class AllTravelsRepoImpl implements AllTravelsRepo {
  final AllTravelsDs allTravelsDs;
  final AllTravelsLocalDs localDs;
  final NetworkInfo networkInfo;

  AllTravelsRepoImpl(
    this.allTravelsDs,
    this.localDs,
    this.networkInfo,
  );


  @override
  Future<Either<ErrorFailures, AllTravelsModel>> getTravels({
    required int PageIndex,
    required int PageSize,
    String? Sort,
    double? MinPrice,
    double? MaxPrice,
    int? CategorieyId,
  }) async {
    print("////////////////////////////////////////////");
    print(await networkInfo.isConnected);
    print("////////////////////////////////////////////");

    final isFiltered = MinPrice != null || MaxPrice != null || CategorieyId != null || (Sort != null && Sort != 'priceDec');

    try {
      if (await networkInfo.isConnected) {
        final data = await allTravelsDs.getTravels(
          PageSize: PageSize,
          PageIndex: PageIndex,
          Sort: Sort,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          CategorieyId: CategorieyId,
        );

        // ✅ Only cache unfiltered data
        if (!isFiltered) {
          await localDs.cacheTravels(data);
          print("✅ Cached unfiltered data");
        }

        return Right(data);
      } else {
        // ✅ Only return cache if no filters applied
        if (!isFiltered) {
          final cached = await localDs.getCachedTravels();
          if (cached != null) {
            print("📦 Using cached travels data");
            return Right(cached);
          } else {
            return Left(ErrorLocalFailure('No internet and no cached data'));
          }
        } else {
          return Left(ErrorLocalFailure('No internet and filters are applied'));
        }
      }
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }

}
