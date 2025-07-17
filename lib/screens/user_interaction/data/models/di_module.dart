import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import 'package:p/screens/user_interaction/data/models/event_interaction_model.dart';

@module
abstract class HiveBoxModule {
  @preResolve
  Future<Box<EventInteractionModel>> get interactionBox =>
      Hive.openBox<EventInteractionModel>('interactions');
}
