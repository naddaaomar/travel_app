import 'package:p/screens/tabs/home/data/models/EventsModel.dart';

abstract class AllEventsDs {
  Future<List<EventsModel>> getEvents();
}
