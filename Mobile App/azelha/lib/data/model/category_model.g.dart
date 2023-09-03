part of 'category_model.dart';

Category _$CategoryItemFromJson(Map<String, dynamic> json) {
  return Category(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    json['position'] as int,
    json['status'] as bool,
    json['defaultImage'] as String,
  );
}

Map<String, dynamic> _$CategoryItemToJson(Category instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'position': instance.position,
      'status': instance.status,
      'assetName': instance.defaultImage
    };
