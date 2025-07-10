import 'dart:async';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:p/screens/tabs/home/data/data_sources/local/home_local_ds.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/tabs/home/data/models/NewestModel.dart';

@Injectable(as: HomeLocalDs)
class HomeLocalDsImpl implements HomeLocalDs {
  // Newest Constants
  static const _boxNameNewest = 'NewestBox';
  static const _boxKeyNewest = 'newestKey';
  static const _collectionNameNewest = 'newest';

  // Events Constants
  static const _boxNameEvents = 'EventsBox';
  static const _boxKeyEvents = 'eventsKey';
  static const _collectionNameEvents = 'events';

  Future<CollectionBox<Map>> _openNewestBox() async {
    final dir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      _boxNameNewest,
      {_collectionNameNewest},
      path: dir.path,
    );
    return await collection.openBox<Map>(_collectionNameNewest);
  }

  Future<CollectionBox<Map>> _openEventsBox() async {
    final dir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      _boxNameEvents,
      {_collectionNameEvents},
      path: dir.path,
    );
    return await collection.openBox<Map>(_collectionNameEvents);
  }

  @override
  Future<void> cacheNewest(NewestModel newestModel) async {
    final box = await _openNewestBox();
    await box.put(_boxKeyNewest, newestModel.toJson());
  }

  @override
  Future<NewestModel?> getCachedNewest() async {
    final box = await _openNewestBox();
    final data = await box.get(_boxKeyNewest);
    if (data == null) return null;
    return NewestModel.fromJson(data);
  }

  @override
  Future<void> cacheEvents(List<EventsModel> eventsModel) async {
    final box = await _openEventsBox();
    final List<Map<dynamic, dynamic>> jsonList = eventsModel.map((e) => e.toJson()).toList();
    await box.put(_boxKeyEvents, {'events': jsonList});
  }



  @override
  Future<List<EventsModel>?> getCachedEvents() async {
    final box = await _openEventsBox();
    final data = await box.get(_boxKeyEvents);
    if (data == null || data['events'] == null) return null;

    final List<dynamic> jsonList = data['events'];
    return jsonList.map((e) => EventsModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }


}
