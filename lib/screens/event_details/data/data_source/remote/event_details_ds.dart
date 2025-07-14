
import 'package:p/screens/event_details/data/models/EventDetailsModel.dart';

abstract class EventDetailsDs {
  Future<EventDetailsModel> getDetails({required String id});
}