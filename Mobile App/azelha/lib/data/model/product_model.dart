import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

class ProductModel {
  List<Product> list;

  ProductModel._internal(this.list);

  factory ProductModel.fromJson(dynamic json) {
    return ProductModel.fromMapList(list: json as List);
  }

  factory ProductModel.fromMapList({List<dynamic> list}) {
    final items =
        list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return Product.fromJson(item);
    }).toList();

    return ProductModel._internal(items);
  }
}

@JsonSerializable()
class Product {
  int id;
  String productCode;
  String name;
  String description;
  double listPrice;
  String sku;
  String defaultImage;
  bool isFavorite;
  double points;
  String barCode;

  Product(
      {this.id,
      this.productCode,
      this.name,
      this.description,
      this.listPrice,
      this.sku,
      this.defaultImage,
      this.isFavorite,
      this.points,
      this.barCode});

  Product.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.productCode = map['productCode'];
    this.name = map['name'];
    this.description = map['description'];
    this.listPrice = map['listPrice'];
    this.sku = map['sku'];
    this.defaultImage = map['defaultImage'];
    this.isFavorite = map['isFavorite'];
    this.points = map['points'];
    this.barCode = map['barCode'];
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this.id,
      'productCode': this.productCode,
      'name': this.name,
      'description': this.description,
      'listPrice': this.listPrice,
      'sku': this.sku,
      'defaultImage': this.defaultImage,
      'isFavorite': this.isFavorite,
      'points': this.points,
      'barCode': this.barCode
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);
}
