import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/tabs/home/data/models/NewestModel.dart';
import 'package:p/screens/tabs/home/domain/repositories/home_repo.dart';

@injectable
class HomeUseCase {
  HomeRepo homeRepo;

  HomeUseCase(this.homeRepo);

  Future<Either<ErrorFailures, NewestModel>> call({
    required int PageIndex,
    required int PageSize,
  }) =>
      homeRepo.getNewest(PageIndex: PageIndex, PageSize: PageSize);

  Future<Either<ErrorFailures, List<EventsModel>>> callEvents() =>
      homeRepo.getEvents();
}
