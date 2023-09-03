part of 'time_model.dart';

TimeItem _$TimeItemFromJson(Map<String, dynamic> json) {
  return TimeItem(
      id: json['id'] as int,
      customerId: json['customerId'] as int,
      isSelected: json['isSelected'] as bool,
      rangeCost: json['rangeCost'] as String,
      orderRange: json['orderRange'] as String);
}

Map<String, dynamic> _$TimeItemToJson(TimeItem instance) => <String, dynamic>{
  'id': instance.id,
  'customerId': instance.customerId,
  'isSelected': instance.isSelected,
  'rangeCost': instance.rangeCost,
  'orderRange': instance.orderRange
};
