import 'dart:async';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:p/screens/tabs/home/data/data_sources/local/recommendation_local_ds.dart';
import 'package:p/screens/tabs/home/data/models/EventRecommendation.dart';
import 'package:p/screens/tabs/home/data/models/TravelRecommendation.dart';
import 'package:path_provider/path_provider.dart';

@Injectable(as: RecommendationLocalDs)
class RecommendationLocalDsImpl implements RecommendationLocalDs {
  // Box & Collection Names
  static const _boxNameTravel = 'TravelRecommendationBox';
  static const _collectionNameTravel = 'travelRecommendations';
  static const _boxKeyTravel = 'travelKey';

  static const _boxNameEvent = 'EventRecommendationBox';
  static const _collectionNameEvent = 'eventRecommendations';
  static const _boxKeyEvent = 'eventKey';

  // Open Box for Travel
  Future<CollectionBox<Map>> _openTravelBox() async {
    final dir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      _boxNameTravel,
      {_collectionNameTravel},
      path: dir.path,
    );
    return await collection.openBox<Map>(_collectionNameTravel);
  }

  // Open Box for Event
  Future<CollectionBox<Map>> _openEventBox() async {
    final dir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      _boxNameEvent,
      {_collectionNameEvent},
      path: dir.path,
    );
    return await collection.openBox<Map>(_collectionNameEvent);
  }

  @override
  Future<void> cacheTravelRecommendations(List<TravelRecommendation> recommendations) async {
    final box = await _openTravelBox();
    final List<Map<String, dynamic>> jsonList = recommendations.map((e) => e.toJson()).toList();
    await box.put(_boxKeyTravel, {'travels': jsonList});
  }

  @override
  Future<List<TravelRecommendation>?> getCachedTravelRecommendations() async {
    final box = await _openTravelBox();
    final data = await box.get(_boxKeyTravel);
    if (data == null || data['travels'] == null) return null;

    final List<dynamic> jsonList = data['travels'];
    return jsonList
        .map((e) => TravelRecommendation.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> cacheEventRecommendations(List<EventRecommendation> recommendations) async {
    final box = await _openEventBox();
    final List<Map<String, dynamic>> jsonList = recommendations.map((e) => e.toJson()).toList();
    await box.put(_boxKeyEvent, {'events': jsonList});
  }

  @override
  Future<List<EventRecommendation>?> getCachedEventRecommendations() async {
    final box = await _openEventBox();
    final data = await box.get(_boxKeyEvent);
    if (data == null || data['events'] == null) return null;

    final List<dynamic> jsonList = data['events'];
    return jsonList
        .map((e) => EventRecommendation.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
