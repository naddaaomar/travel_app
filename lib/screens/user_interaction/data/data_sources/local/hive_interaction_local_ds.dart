import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:p/screens/user_interaction/data/models/event_interaction_model.dart';

abstract class HiveInteractionLocalDataSource {
  Future<List<EventInteractionModel>> getAllInteractions();
  Future<void> saveInteraction(EventInteractionModel interaction);
  Future<void> clearAll();
}

@LazySingleton(as: HiveInteractionLocalDataSource)
class HiveInteractionLocalDataSourceImpl implements HiveInteractionLocalDataSource {
  final Box<EventInteractionModel> box;

  HiveInteractionLocalDataSourceImpl(this.box);

  @override
  Future<List<EventInteractionModel>> getAllInteractions() async {
    return box.values.toList();
  }

  @override
  Future<void> saveInteraction(EventInteractionModel interaction) async {
    await box.add(interaction);
  }

  @override
  Future<void> clearAll() async {
    await box.clear();
  }
}
