import 'package:p/screens/travel_filtration/data/models/CategoryModel.dart';

abstract class LocalCategoriesDs {
  Future<void> cacheCategories(List<CategoryModel> categories);
  Future<List<CategoryModel>?> getCachedCategories();
}