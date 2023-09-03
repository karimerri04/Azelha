import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  int id;
  String fullName;
  String email;
  String passwordHash;
  String phone;
  int otpNum;

  User({
    this.id,
    this.fullName,
    this.email,
    this.passwordHash,
    this.phone,
    this.otpNum,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserItemFromJson(json);

  User.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.fullName = map['fullName'];
    this.email = map['email'];
    this.phone = map['phone'];
    this.otpNum = map['otpNum'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this.id,
      'fullName': this.fullName,
      'email': this.email,
      'phone': this.phone,
      'otpNum': this.otpNum,
    };
  }
}
