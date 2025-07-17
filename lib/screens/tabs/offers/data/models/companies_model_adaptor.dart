// Add this class to your project
import 'package:hive_flutter/adapters.dart';
import 'package:p/screens/all_companies/data/models/AllCompaniesModel.dart';

class AllCompaniesModelAdapter extends TypeAdapter<AllCompaniesModel> {
  @override
  final int typeId = 0; // Unique ID for this adapter

  @override
  AllCompaniesModel read(BinaryReader reader) {
    final map = reader.readMap().map((key, value) =>
        MapEntry(key as String, value));
    return AllCompaniesModel.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, AllCompaniesModel obj) {
    writer.writeMap(obj.toJson());
  }
}