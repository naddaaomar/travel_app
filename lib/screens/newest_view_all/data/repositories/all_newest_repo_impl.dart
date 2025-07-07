import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/newest_view_all/data/remote/data_sources/all_newest_ds.dart';
import 'package:p/screens/newest_view_all/data/remote/models/AllNewestModel.dart';
import 'package:p/screens/newest_view_all/domain/repositories/all_newest_repo.dart';


@Injectable(as: AllNewestRepo)
class AllNewestRepoImpl implements AllNewestRepo {
  AllNewestDs allNewestDs;
  AllNewestRepoImpl(this.allNewestDs);

  @override
  Future<Either<ErrorFailures, AllNewestModel>> getNewest(
      {required int PageIndex, required int PageSize,
        String? Sort,
        double?MinPrice,
        double?MaxPrice,
        int? CategorieyId
      }) async {
    try {
      var data = await allNewestDs.getNewest(
          PageSize: PageSize, PageIndex: PageIndex,
          MaxPrice: MaxPrice,MinPrice: MinPrice,Sort: Sort,CategorieyId: CategorieyId);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}
