import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/events_details/data/models/EventDetailsModel.dart';

abstract class EventDetailsRepo {

  Future<Either<ErrorFailures, EventDetailsModel>> getDetails({required String id});
}
