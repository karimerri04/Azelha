import 'package:json_annotation/json_annotation.dart';

part 'time_model.g.dart';

class TimeModel {
  List<TimeItem> addressList;

  TimeModel._internal(this.addressList);

  factory TimeModel.fromJson(dynamic json) {
    return TimeModel.fromMapList(list: json as List);
  }

  factory TimeModel.fromMapList({List<dynamic> list}) {
    final items =
    list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return TimeItem.fromMap(item);
    }).toList();

    return TimeModel._internal(items);
  }
}

@JsonSerializable()
class TimeItem {
  int id;
  int customerId;
  bool isSelected;
  String rangeCost;
  String orderRange;

  TimeItem(
      {this.id,
        this.customerId,
        this.isSelected,
        this.rangeCost,
        this.orderRange});

  TimeItem.fromMap(Map<String, dynamic> map) {
    this.id = map['_id'];
    this.customerId = map['customerId'];
    this.rangeCost = map['rangeCost'];
    this.orderRange = map['orderRange'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': this.id,
      'customerId': this.customerId,
      'rangeCost': this.rangeCost,
      'orderRange': this.orderRange
    };
  }
}
