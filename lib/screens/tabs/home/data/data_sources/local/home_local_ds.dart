import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/tabs/home/data/models/NewestModel.dart';

abstract class HomeLocalDs {
  Future<void> cacheNewest(NewestModel newestModel);
  Future<NewestModel?> getCachedNewest();
  Future<void> cacheEvents(List<EventsModel> eventsModel);
  Future<List<EventsModel>?> getCachedEvents();
}