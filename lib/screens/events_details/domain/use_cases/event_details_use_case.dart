import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/events_details/data/models/EventDetailsModel.dart';
import 'package:p/screens/events_details/domain/repositories/event_details_repo.dart';

@injectable
class EventDetailsUseCase {
  EventDetailsRepo eventDetailsRepo;

  EventDetailsUseCase(this.eventDetailsRepo);

  Future<Either<ErrorFailures, EventDetailsModel>> callDetails(
          {required String id}) =>
      eventDetailsRepo.getDetails(id: id);
}
