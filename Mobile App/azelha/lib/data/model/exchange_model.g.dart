part of 'exchange_model.dart';

Exchange _$ExchangeArticleFromJson(Map<String, dynamic> json) {
  return Exchange(
      id: json['id'] as int,
      ecocard: json['ecocard'] as Map<String, dynamic>,
      point: json['point'] as double,
      status: json['status'] as bool);
}

Map<String, dynamic> _$ExchangeArticleToJson(Exchange instance) => <String, dynamic>{
  'ecocard': instance.ecocard,
  'point': instance.point,
  'status': instance.status
};
