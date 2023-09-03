import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

class ArticleModel {
  List<Article> articleList;

  ArticleModel._internal(this.articleList);
  factory ArticleModel.fromJson(dynamic json) {
    return ArticleModel.fromMapList(list: json as List);
  }
  // Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  factory ArticleModel.fromMapList({List<dynamic> list}) {
    final items =
        list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return Article.fromJson(item);
    }).toList();

    return ArticleModel._internal(items);
  }
}

@JsonSerializable()
class Article {
  int id;
  String barcode_number;
  String barcode_type;
  String barcode_formats;
  String mpn;
  String model;
  String asin;
  String package_quantity;
  String size;
  String length;
  String width;
  String height;
  String weight;
  String description;
  String image;
  int points;
  String status;
  Map<String, dynamic> product;
  Article(
      {this.id,
      this.barcode_number,
      this.barcode_type,
      this.barcode_formats,
      this.mpn,
      this.model,
      this.asin,
      this.package_quantity,
      this.size,
      this.length,
      this.width,
      this.height,
      this.weight,
      this.description,
      this.image,
      this.points,
      this.status,
      this.product});

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ScanArticleFromJson(json);

  Article.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.barcode_number = map['barcode_number'];
    this.barcode_type = map['barcode_type'];
    this.barcode_formats = map['barcode_formats'];
    this.mpn = map['mpn'];
    this.model = map['model'];
    this.asin = map['asin'];
    this.package_quantity = map['package_quantity'];
    this.size = map['size'];
    this.length = map['length'];
    this.width = map['width'];
    this.height = map['height'];
    this.weight = map['weight'];
    this.description = map['description'];
    this.image = map['image'];
    this.points = map['points'];
    this.status = map['status'];
    this.product = map['product'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': this.id,
      'barcode_number': this.barcode_number,
      'barcode_type': this.barcode_type,
      'barcode_formats': this.barcode_formats,
      'mpn': this.mpn,
      'model': this.model,
      'asin': this.asin,
      'package_quantity': this.package_quantity,
      'size': this.size,
      'length': this.length,
      'width': this.width,
      'height': this.height,
      'weight': this.weight,
      'description': this.description,
      'image': this.image,
      'points': this.points,
      'status': this.status,
      'product': this.product,
    };
  }
}
