import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

class CategoryModel {
  List<Category> categoryList;

  CategoryModel._internal(this.categoryList);

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel.fromMapList(list: json as List);
  }

  factory CategoryModel.fromMapList({List<dynamic> list}) {
    final items =
    list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return Category.fromJson(item);
    }).toList();

    return CategoryModel._internal(items);
  }
}

@JsonSerializable()
class Category {
  final int id;
  final String name;
  final String description;
  final int position;
  final bool status;
  final String defaultImage;

  Category(this.id, this.name, this.description, this.position, this.status,
      this.defaultImage);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);
}
