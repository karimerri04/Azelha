part of 'product_model.dart';

Product _$ProductItemFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    productCode: json['productCode'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    listPrice: json['listPrice'] as double,
    sku: json['sku'] as String,
    defaultImage: json['defaultImage'] as String,
    isFavorite: json['isFavorite'] as bool,
    points: json['points'] as double,
    barCode: json['barCode'] as String,
  );
}

Map<String, dynamic> _$ProductItemToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'productCode': instance.productCode,
      'name': instance.name,
      'description': instance.description,
      'listPrice': instance.listPrice,
      'sku': instance.sku,
      'defaultImage': instance.defaultImage,
      'isFavorite': instance.isFavorite,
      'points': instance.points,
      'barCode': instance.barCode
    };
