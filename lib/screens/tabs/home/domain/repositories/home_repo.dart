import 'package:dartz/dartz.dart';
import 'package:p/helpers/exceptions/failuers.dart';
import 'package:p/screens/tabs/home/data/models/EventRecommendation.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/tabs/home/data/models/NewestModel.dart';
import 'package:p/screens/tabs/home/data/models/TravelRecommendation.dart';

abstract class HomeRepo {
  Future<Either<ErrorFailures, NewestModel>> getNewest({
    required int PageIndex,
    required int PageSize,
  });
  Future<Either<ErrorFailures, List<EventsModel>>> getEvents();
  Future<Either<ErrorFailures, List<TravelRecommendation>>> getTravelRecommend({
    required int numRecommendations,
    required int numHighestInteractions,
  });
  Future<Either<ErrorFailures, List<EventRecommendation>>> getEventRecommend({
    required int numRecommendations,
    required int numHighestInteractions,
  });
}
