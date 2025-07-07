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
    print(await networkInfo.isConnected);
    print(await networkInfo.isConnected);
    print(await networkInfo.isConnected);
    print("////////////////////////////////////////////");

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

        await localDs.cacheTravels(data);
        print("data safedddddddddd");
        return Right(data);
      } else {
        final cached = await localDs.getCachedTravels();
        if (cached != null) {
          print("📦 Using cached travels data");

          return Right(cached);
        } else {
          return Left(ErrorLocalFailure('No internet and no cached data'));
        }
      }
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}
