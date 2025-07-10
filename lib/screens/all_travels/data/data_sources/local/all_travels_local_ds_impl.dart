import 'dart:async';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:p/screens/all_travels/data/models/AllTravelsModel.dart';
import 'all_travels_local_ds.dart';

@Injectable(as: AllTravelsLocalDs)
class AllTravelsLocalDsImpl implements AllTravelsLocalDs {
  static const _boxName = 'Travels';
  static const _boxKey = 'allTravels';
  static const _boxCollection = 'travels';

  Future<CollectionBox<Map>> _openBox() async {
    final dir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      _boxName,
      {_boxCollection},
      path: dir.path,
    );
    return await collection.openBox<Map>(_boxCollection);
  }

  @override
  Future<void> cacheTravels(AllTravelsModel travels) async {
    final box = await _openBox();
    await box.put(_boxKey, travels.toJson());
  }

  @override
  Future<AllTravelsModel?> getCachedTravels() async {
    final box = await _openBox();
    final data = await box.get(_boxKey);
    if (data == null) return null;
    return AllTravelsModel.fromJson(data);
  }
}