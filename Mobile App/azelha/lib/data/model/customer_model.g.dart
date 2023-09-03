part of 'customer_model.dart';

Customer _$CustomerItemFromJson(Map<String, dynamic> json) {
  return Customer(
      id: json['id'] as int,
    createDate: json['createDate'] as String,
      user: json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CustomerItemToJson(Customer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate,
      'user': instance.user,
    };
