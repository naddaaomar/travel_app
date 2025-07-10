import 'package:hive/hive.dart';

part 'event_interaction.g.dart'; // make sure this matches your file

@HiveType(typeId: 0)
class EventInteraction extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String type;

  @HiveField(2)
  int userCheckOut;

  @HiveField(3)
  bool addedToWishList;

  @HiveField(4)
  bool booked;

  @HiveField(5)
  double total;

  EventInteraction({
    required this.id,
    required this.type,
    required this.userCheckOut,
    required this.addedToWishList,
    required this.booked,
  }) : total = userCheckOut + (addedToWishList ? 3 : 0) + (booked ? 5 : 0);

  void recalculateTotal() {
    total = userCheckOut + (addedToWishList ? 3 : 0) + (booked ? 5 : 0);
  }

  Map<String, dynamic> toApiJson() {
    return {
      "id": id,
      "type": type,
      "total": total,
    };
  }
}
