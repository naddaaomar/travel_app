/// id : 1
/// categoryName : "Adventure"

class CategoryModel {
  CategoryModel({
      int? id,
      String? categoryName,}){
    _id = id;
    _categoryName = categoryName;
}

  CategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _categoryName = json['categoryName'];
  }
  int? _id;
  String? _categoryName;
CategoryModel copyWith({  int? id,
  String? categoryName,
}) => CategoryModel(  id: id ?? _id,
  categoryName: categoryName ?? _categoryName,
);
  int? get id => _id;
  String? get categoryName => _categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['categoryName'] = _categoryName;
    return map;
  }

}
