import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import '../../domain/repositories/all_companies_repo.dart';
import '../data_sources/local/all_companies_local_ds.dart';
import '../data_sources/remote/all_companies_ds.dart';
import '../models/AllCompaniesModel.dart';
import '../../../../helpers/internet_checker/internet_checker.dart';

@Injectable(as: AllCompaniesRepo)
class AllCompaniesRepoImpl implements AllCompaniesRepo {
  final AllCompaniesDs remoteDs;
  final AllCompaniesLocalDs localDs;
  final NetworkInfo networkInfo;

  AllCompaniesRepoImpl(this.remoteDs, this.localDs, this.networkInfo);

  @override
  Future<Either<ErrorFailures, AllCompaniesModel>> getCompanies({
    required int PageIndex,
    required int PageSize,
    String? sort,
    int? rate,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final data = await remoteDs.getCompanies(
          PageSize: PageSize,
          PageIndex: PageIndex,
          sort: sort,
          rate: rate,
        );
        await localDs.cacheCompanies(data);
        print("✅ Companies cached");
        return Right(data);
      } else {
        final cached = await localDs.getCachedCompanies();
        if (cached != null) {
          print("📦 Using cached companies");
          return Right(cached);
        } else {
          return Left(ErrorLocalFailure("No internet and no cached companies"));
        }
      }
    } catch (e) {
      print(e.toString());
      return Left(ErrorRemoteFailure(e.toString()));

    }
  }
}
