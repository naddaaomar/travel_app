import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/view_all_events/domain/repositories/all_events_repo.dart';

import '../data_sources/remote/all_events_ds.dart';

@Injectable(as: AllEventsRepo)
class AllEventsRepoImpl implements AllEventsRepo {
  final AllEventsDs allEventsDs;

  AllEventsRepoImpl(
    this.allEventsDs,
  );

  @override
  Future<Either<ErrorFailures, List<EventsModel>>> getEvents() async {
    try {
      var data = await allEventsDs.getEvents();
      return Right(data);
    } catch (e) {
      return Left(ErrorRemoteFailure(e.toString()));
    }
  }
}
