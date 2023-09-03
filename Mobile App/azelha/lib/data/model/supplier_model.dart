import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'supplier_model.g.dart';

class SupplierModel {
  List<Supplier> addressList;

  SupplierModel._internal(this.addressList);

  factory SupplierModel.fromJson(dynamic json) {
    return SupplierModel.fromMapList(list: json as List);
  }
  factory SupplierModel.fromMapList({List<dynamic> list}) {
    final items =
    list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return Supplier.fromJson(item);
    }).toList();

    return SupplierModel._internal(items);
  }
}

@JsonSerializable()
class Supplier {
  int id;
  String name;
  String description;
  bool status;
  String logo;
  Supplier({this.id, this.name, this.description, this.status, this.logo});

  factory Supplier.fromJson(Map<String, dynamic> json) =>
      _$SupplierItemFromJson(json);

  Supplier.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.description = map['description'];
    this.status = map['status'];
    this.logo = map['logo'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'status': this.status,
      'logo': this.logo
    };
  }
}
