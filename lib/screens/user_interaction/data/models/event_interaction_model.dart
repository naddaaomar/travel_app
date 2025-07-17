import 'package:hive/hive.dart';
import '../../domain/entities/event_interaction.dart';

part 'event_interaction_model.g.dart';

@HiveType(typeId: 0)
class EventInteractionModel extends EventInteraction {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  int userCheckOut;

  @HiveField(3)
  bool addedToWishList;

  @HiveField(4)
  bool booked;

  @HiveField(5)
  double total;

  EventInteractionModel({
    required this.id,
    required this.type,
    required this.userCheckOut,
    required this.addedToWishList,
    required this.booked,
  })  : total = userCheckOut + (addedToWishList ? 3 : 0) + (booked ? 5 : 0),
        super(id: id, type: type, total: userCheckOut + (addedToWishList ? 3 : 0) + (booked ? 5 : 0));
}
