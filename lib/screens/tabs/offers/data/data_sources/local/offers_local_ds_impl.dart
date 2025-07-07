import 'dart:async';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:p/screens/all_companies/data/models/AllCompaniesModel.dart';
import 'package:p/screens/tabs/offers/data/models/DiscountTravelsModel.dart';

import 'offers_local_ds.dart';

@Injectable(as: OffersLocalDs)
class OffersLocalDsImpl implements OffersLocalDs {
  static const _boxName = 'OffersBox';
  static const _collectionName = 'offers';
  static const _companiesKey = 'cached_companies';
  static const _discountsKey = 'cached_discounts';

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
    final box = await _openBox();
    await box.put(_companiesKey, companies.toJson());
  }

  @override
  Future<AllCompaniesModel?> getCachedCompanies() async {
    final box = await _openBox();
    final data = await box.get(_companiesKey);
    if (data == null) return null;
    return AllCompaniesModel.fromJson(data);
  }

  @override
  Future<void> cacheDiscounts(DiscountTravelsModel discounts) async {
    final box = await _openBox();
    await box.put(_discountsKey, discounts.toJson());
  }

  @override
  Future<DiscountTravelsModel?> getCachedDiscounts() async {
    final box = await _openBox();
    final data = await box.get(_discountsKey);
    if (data == null) return null;
    return DiscountTravelsModel.fromJson(data);
  }
}
