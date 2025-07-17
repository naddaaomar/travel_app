import 'dart:async';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:p/screens/all_discount_travels/data/remote/models/DiscountItemsModel.dart';
import 'package:path_provider/path_provider.dart';

import 'offers_local_ds.dart';

@Injectable(as: OffersLocalDs)
class OffersLocalDsImpl implements OffersLocalDs {
  static const _boxName = 'OffersBox';
  static const _collectionName = 'offers';
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
  Future<void> cacheDiscounts(DiscountItemsModel discounts) async {
    final box = await _openBox();
    await box.put(_discountsKey, discounts.toJson());
  }

  @override
  Future<DiscountItemsModel?> getCachedDiscounts() async {
    final box = await _openBox();
    final data = await box.get(_discountsKey);
    if (data == null) return null;
    return DiscountItemsModel.fromJson(data);
  }
}