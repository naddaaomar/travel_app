import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/travel_filtration/data/models/CategoryModel.dart';
import 'package:p/screens/travel_filtration/domain/repositories/travel_filter_repo.dart';

@injectable
class TravelFilterUseCase {
  TravelFilterRepo travelFilterRepo;

  TravelFilterUseCase(this.travelFilterRepo);

  Future<Either<ErrorFailures, List<CategoryModel>>> call() =>
      travelFilterRepo.getCategories();
}