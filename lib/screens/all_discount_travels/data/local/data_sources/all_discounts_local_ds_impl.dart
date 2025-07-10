import 'dart:async';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:p/screens/all_discount_travels/data/remote/models/AllDiscountModel.dart';

import 'all_discounts_local_ds.dart';

@Injectable(as: AllDiscountsLocalDs)
class AllDiscountsLocalDsImpl implements AllDiscountsLocalDs {
  static const _boxName = 'Discounts';
  static const _boxKey = 'allDiscounts';
  static const _collectionName = 'discounts';

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
  Future<void> cacheDiscounts(AllDiscountModel discounts) async {
    final box = await _openBox();
    await box.put(_boxKey, discounts.toJson());
  }

  @override
  Future<AllDiscountModel?> getCachedDiscounts() async {
    final box = await _openBox();
    final data = await box.get(_boxKey);
    if (data == null) return null;
    return AllDiscountModel.fromJson(data);
  }
}