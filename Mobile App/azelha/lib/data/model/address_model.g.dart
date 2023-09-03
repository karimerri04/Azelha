part of 'address_model.dart';

Addresss _$AddressItemFromJson(Map<String, dynamic> json) {
  return Addresss(
    id: json['id'] as int,
    addressLine1: json['addressLine1'] as String,
    addressLine2: json['addressLine2'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    postalCode: json['postalCode'] as String,
    country: json['country'] as String,
    isActive: json['isActive'] as bool,
    point: json['point'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$AddressItemToJson(Addresss instance) => <String, dynamic>{
  'id': instance.id,
  'addressLine1': instance.addressLine1,
  'addressLine2': instance.addressLine2,
  'city': instance.city,
  'state': instance.state,
  'postalCode': instance.postalCode,
  'country': instance.country,
  'isActive': instance.isActive,
  'point': instance.point,
};
