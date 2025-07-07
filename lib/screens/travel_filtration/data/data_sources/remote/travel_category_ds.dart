import 'package:p/screens/travel_filtration/data/models/CategoryModel.dart';

abstract class TravelCategoryDs {
  Future<List<CategoryModel>> getCategories();
}
