import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

class AddressModel {
  List<Addresss> addressList;

  AddressModel._internal(this.addressList);

  factory AddressModel.fromJson(dynamic json) {
    return AddressModel.fromMapList(list: json as List);
  }
  factory AddressModel.fromMapList({List<dynamic> list}) {
    final items =
        list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return Addresss.fromJson(item);
    }).toList();

    return AddressModel._internal(items);
  }
}

@JsonSerializable()
class Addresss {
  int id;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String country;
  bool isActive;
  String postalCode;
  Map<String, dynamic> point;
  Map<String, dynamic> user;

  Addresss(
      {this.id,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.state,
      this.postalCode,
      this.country,
      this.isActive,
      this.point,
      this.user});

  factory Addresss.fromJson(Map<String, dynamic> json) =>
      _$AddressItemFromJson(json);

  Addresss.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.addressLine1 = map['addressLine1'];
    this.addressLine2 = map['addressLine2'];
    this.city = map['city'];
    this.state = map['state'];
    this.postalCode = map['postalCode'];
    this.country = map['country'];
    this.isActive = map['isActive'];
    this.point = map['point'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this.id,
      'addressLine1': this.addressLine1,
      'addressLine2': this.addressLine2,
      'city': this.city,
      'state': this.state,
      'postalCode': this.postalCode,
      'country': this.country,
      'isActive': this.isActive,
      'point': this.point,
      'user': this.user
    };
  }
}
