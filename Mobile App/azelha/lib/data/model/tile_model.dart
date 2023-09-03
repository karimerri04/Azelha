import 'package:json_annotation/json_annotation.dart';

part 'tile_model.g.dart';

class TileModel {
  List<TileItem> addressList;

  TileModel._internal(this.addressList);

  factory TileModel.fromJson(dynamic json) {
    return TileModel.fromMapList(list: json as List);
  }

  factory TileModel.fromMapList({List<dynamic> list}) {
    final items =
    list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return TileItem.fromMap(item);
    }).toList();

    return TileModel._internal(items);
  }
}

@JsonSerializable()
class TileItem {
  int id;
  String description;
  String amount;

  TileItem({this.id, this.description, this.amount});

  TileItem.fromMap(Map<String, dynamic> map) {
    this.id = map['_id'];
    this.description = map['description'];
    this.amount = map['amount'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': this.id,
      'description': this.description,
      'amount': this.amount
    };
  }
}
