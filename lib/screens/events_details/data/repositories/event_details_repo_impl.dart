import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/events_details/data/data_sources/remote/event_details_ds.dart';
import 'package:p/screens/events_details/data/models/EventDetailsModel.dart';
import 'package:p/screens/events_details/domain/repositories/event_details_repo.dart';

@Injectable(as: EventDetailsRepo)
class EventDetailsRepoImpl implements EventDetailsRepo {
  final EventDetailsDs eventDetailsDs;


  EventDetailsRepoImpl(this.eventDetailsDs,);


  @override
  Future<Either<ErrorFailures, EventDetailsModel>> getDetails({required String id})async {

    try {
      var data = await eventDetailsDs.getDetails(id: id);
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}
