import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/travel_filtration/data/data_sources/local/local_categories_ds.dart';
import 'package:p/screens/travel_filtration/data/models/CategoryModel.dart';
import '../../domain/repositories/travel_filter_repo.dart';
import '../data_sources/remote/travel_category_ds.dart';

@Injectable(as: TravelFilterRepo)

class TravelFilterRepoImpl implements TravelFilterRepo {
  final TravelCategoryDs remoteDs;
  final LocalCategoriesDs localDs;

  TravelFilterRepoImpl(this.remoteDs, this.localDs);

  @override
  Future<Either<ErrorFailures, List<CategoryModel>>> getCategories() async {
    try {
      final data = await remoteDs.getCategories();
      await localDs.cacheCategories(data);
      return Right(data);
    } catch (_) {
      final cached = await localDs.getCachedCategories();
      if (cached != null) {
        return Right(cached);
      } else {
        return Left(ErrorLocalFailure("No internet and no cached categories."));
      }
    }
  }
}