import 'package:injectable/injectable.dart';
import '../../data/models/event_interaction_model.dart';
import '../repositories/interaction_repository.dart';

@injectable
class SaveInteractionUseCase {
  final InteractionRepository repository;

  SaveInteractionUseCase(this.repository);

  Future<void> call(EventInteractionModel interaction) {
    return repository.saveInteraction(interaction);
  }
}
