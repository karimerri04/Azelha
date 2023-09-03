part of 'tile_model.dart';

TileItem _$TileItemFromJson(Map<String, dynamic> json) {
  return TileItem(
      id: json['id'] as int,
      description: json['description'] as String,
      amount: json['amount'] as String);
}

Map<String, dynamic> _$TileItemToJson(TileItem instance) => <String, dynamic>{
  'id': instance.id,
  'description': instance.description,
  'amount': instance.amount
};
