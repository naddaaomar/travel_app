// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_interaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventInteractionModelAdapter extends TypeAdapter<EventInteractionModel> {
  @override
  final int typeId = 0;

  @override
  EventInteractionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventInteractionModel(
      id: fields[0] as String,
      type: fields[1] as String,
      userCheckOut: fields[2] as int,
      addedToWishList: fields[3] as bool,
      booked: fields[4] as bool,
    )..total = fields[5] as double;
  }

  @override
  void write(BinaryWriter writer, EventInteractionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.userCheckOut)
      ..writeByte(3)
      ..write(obj.addedToWishList)
      ..writeByte(4)
      ..write(obj.booked)
      ..writeByte(5)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventInteractionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
