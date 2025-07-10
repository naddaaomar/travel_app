import 'dart:async';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:p/screens/all_companies/data/models/AllCompaniesModel.dart';

import 'all_companies_local_ds.dart';

@Injectable(as: AllCompaniesLocalDs)
class AllCompaniesLocalDsImpl implements AllCompaniesLocalDs {
  static const _boxName = 'Companies';
  static const _boxKey = 'allCompanies';
  static const _collectionName = 'companies';

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
    try{
      final box = await _openBox();
      await box.put(_boxKey, companies.toJson());
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Future<AllCompaniesModel?> getCachedCompanies() async {
    final box = await _openBox();
    final data = await box.get(_boxKey);
    if (data == null) return null;
    return AllCompaniesModel.fromJson(data);
  }
}
