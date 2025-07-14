import 'package:p/screens/tabs/home/data/models/EventRecommendation.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/tabs/home/data/models/NewestModel.dart';
import 'package:p/screens/tabs/home/data/models/TravelRecommendation.dart';

abstract class HomeDs {
  Future<NewestModel> getNewest({
    required int PageSize,
    required int PageIndex,
  });
  Future<List<EventsModel>> getEvents();
  Future<List<TravelRecommendation>> getTravelRecommend({

    required int numRecommendations,
    required int numHighestInteractions,
  });
  Future<List<EventRecommendation>> getEventRecommend({

    required int numRecommendations,
    required int numHighestInteractions,
  });
}
