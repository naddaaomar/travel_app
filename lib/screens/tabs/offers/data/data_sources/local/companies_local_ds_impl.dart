import 'dart:async';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:p/screens/all_companies/data/models/AllCompaniesModel.dart';
import 'package:path_provider/path_provider.dart';

import 'companies_local_ds.dart';

@Injectable(as: CompaniesLocalDs)
class CompaniesLocalDsImpl implements CompaniesLocalDs {
  static const _boxName = 'CompaniesBox';
  static const _collectionName = 'companies';
  static const _companiesKey = 'cached_companies';

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
  Future<void> cacheCompanies(AllCompaniesModel companies) async {
    try {
      final box = await _openBox();

      // Convert to JSON first, then ensure it's a Map
      final jsonData = companies.toJson();
      print('JSON data type before storage: ${jsonData.runtimeType}');

      await box.put(_companiesKey, jsonData);
      print('✅ Successfully cached companies data');
    } catch (e, stackTrace) {
      print('⚠️ Error caching companies: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<AllCompaniesModel?> getCachedCompanies() async {
    try {
      final box = await _openBox();
      final data = await box.get(_companiesKey);

      if (data == null) return null;

      print('Retrieved data type: ${data.runtimeType}');

      // Ensure we're working with a Map
      final jsonData = data is Map<String, dynamic>
          ? data
          : Map<String, dynamic>.from(data as Map);

      return AllCompaniesModel.fromJson(jsonData);
    } catch (e, stackTrace) {
      print('⚠️ Error retrieving cached companies: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
}