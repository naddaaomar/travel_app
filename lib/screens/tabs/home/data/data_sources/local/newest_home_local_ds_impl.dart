import 'dart:async';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:p/screens/tabs/home/data/models/NewestModel.dart';
import 'newest_home_local_ds.dart';

@Injectable(as: NewestHomeLocalDs)
class NewestHomeLocalDsImpl implements NewestHomeLocalDs {
  static const _boxName = 'NewestBox';
  static const _boxKey = 'newestKey';
  static const _collectionName = 'newest';

  Future<CollectionBox<Map>> _openBox() async {
    final dir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      _boxName,
      {_collectionName},
      path: dir.path,
    );
    return await collection.openBox<Map>(_collectionName);
  }

  @override
  Future<void> cacheNewest(NewestModel newestModel) async {
    final box = await _openBox();
    await box.put(_boxKey, newestModel.toJson());
  }

  @override
  Future<NewestModel?> getCachedNewest() async {
    final box = await _openBox();
    final data = await box.get(_boxKey);
    if (data == null) return null;
    return NewestModel.fromJson(data);
  }
}
