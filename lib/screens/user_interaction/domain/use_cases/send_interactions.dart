import 'package:injectable/injectable.dart';
import 'package:p/screens/user_interaction/data/models/event_interaction_model.dart';

import '../repositories/interaction_repository.dart';
@injectable
class SendInteractionsUseCase {
  final InteractionRepository repository;

  SendInteractionsUseCase(this.repository);

  Future<void> call(String userId) async {
    await repository.sendAllInteractions(userId);
  }

  Future<void> callSave(EventInteractionModel interaction) {
    return repository.saveInteraction(interaction);
  }
}
