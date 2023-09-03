import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

class CustomerModel {
  List<Customer> list;

  CustomerModel._internal(this.list);

  factory CustomerModel.fromJson(dynamic json) {
    return CustomerModel.fromMapList(list: json as List);
  }

  factory CustomerModel.fromMapList({List<dynamic> list}) {
    final items =
    list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return Customer.fromJson(item);
    }).toList();

    return CustomerModel._internal(items);
  }
}


@JsonSerializable()
class Customer {
  int id;
  String createDate;
  Map<String, dynamic> user;

  Customer(
      {this.id,
        this.createDate,
        this.user
     });


  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerItemFromJson(json);

  Customer.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.createDate = map['createDate'];
    this.user = map['user'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this.id,
      'createDate': this.createDate,
      'user': this.user
    };
  }


}
