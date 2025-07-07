import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:p/screens/travel_filtration/data/models/CategoryModel.dart';
import 'local_categories_ds.dart';

@Injectable(as: LocalCategoriesDs)
class LocalCategoriesDsImpl implements LocalCategoriesDs {
  static const _boxName = 'Categories';
  static const _boxKey = 'allCategories';
  static const _boxCollection = 'categories';

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
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    final box = await _openBox();
    final categoryListJson = categories.map((e) => e.toJson()).toList();
    await box.put(_boxKey, {"categories": categoryListJson});
  }

  @override
  Future<List<CategoryModel>?> getCachedCategories() async {
    final box = await _openBox();
    final data = await box.get(_boxKey);
    if (data == null) return null;

    final List rawList = data["categories"];
    return rawList.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
