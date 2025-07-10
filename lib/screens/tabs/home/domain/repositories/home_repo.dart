import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/tabs/home/data/models/NewestModel.dart';

abstract class HomeRepo {
  Future<Either<ErrorFailures, NewestModel>> getNewest({
    required int PageIndex,
    required int PageSize,
  });
  Future<Either<ErrorFailures, List<EventsModel>>> getEvents();
}
