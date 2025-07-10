import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';

import '../../data/models/AllTravelsModel.dart';
import '../repositories/all_travels_repo.dart';

@injectable
class AllTravelsUseCase {
  AllTravelsRepo allTravelsRepo;

  AllTravelsUseCase(this.allTravelsRepo);

  Future<Either<ErrorFailures, AllTravelsModel>> call(
      {required int PageIndex,
        required int PageSize,
        String? Sort,
        double? MinPrice,
        double? MaxPrice,
        int? CategorieyId}) =>
      allTravelsRepo.getTravels(
          PageIndex: PageIndex,
          PageSize: PageSize,
          Sort: Sort,
          MinPrice: MinPrice,
          MaxPrice: MaxPrice,
          CategorieyId: CategorieyId);
}