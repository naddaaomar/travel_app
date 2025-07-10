import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/newest_view_all/data/remote/models/AllNewestModel.dart';
import 'package:p/screens/newest_view_all/domain/repositories/all_newest_repo.dart';

@injectable
class AllNewestUseCase {
  AllNewestRepo allNewestRepo;

  AllNewestUseCase(this.allNewestRepo);

  Future<Either<ErrorFailures, AllNewestModel>> call(
      {required int PageIndex,
        required int PageSize,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) =>
      allNewestRepo.getNewest(
          PageIndex: PageIndex,
          PageSize: PageSize,
          Sort: Sort,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          CategorieyId: CategorieyId);
}