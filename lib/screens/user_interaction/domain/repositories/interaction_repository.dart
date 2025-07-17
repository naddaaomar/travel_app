import 'package:p/screens/user_interaction/data/models/event_interaction_model.dart';


abstract class InteractionRepository {
  Future<void> sendAllInteractions(String userId);
  Future<void> saveInteraction(EventInteractionModel interaction);
}
