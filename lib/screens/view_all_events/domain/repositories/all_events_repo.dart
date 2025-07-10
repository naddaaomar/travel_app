import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';

abstract class AllEventsRepo {
  Future<Either<ErrorFailures, List<EventsModel>>> getEvents();
}
