import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';

import '../repositories/all_events_repo.dart';

@injectable
class AllEventsUseCase {
  AllEventsRepo allEventsRepo;

  AllEventsUseCase(this.allEventsRepo);

  Future<Either<ErrorFailures, List<EventsModel>>> callEvents() =>
      allEventsRepo.getEvents();
}
