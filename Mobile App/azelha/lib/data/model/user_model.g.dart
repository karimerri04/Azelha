part of 'user_model.dart';

User _$UserItemFromJson(Map<String, dynamic> json) {
  return User(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      otpNum: json['otpNum'] as int);
}

Map<String, dynamic> _$UserItemToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'otpNum': instance.otpNum,
};
