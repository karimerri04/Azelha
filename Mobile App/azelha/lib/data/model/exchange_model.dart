import 'package:json_annotation/json_annotation.dart';

part 'exchange_model.g.dart';

class ExchangeModel {
  List<Exchange> exchangeList;

  ExchangeModel._internal(this.exchangeList);

  factory ExchangeModel.fromJson(dynamic json) {
    return ExchangeModel.fromMapList(list: json as List);
  }

  factory ExchangeModel.fromMapList({List<dynamic> list}) {
    final items =
    list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return Exchange.fromMap(item);
    }).toList();

    return ExchangeModel._internal(items);
  }
}

@JsonSerializable()
class Exchange {
  int id;
  Map<String, dynamic> ecocard;
  double point;
  bool status;

  Exchange({this.id, this.ecocard, this.point, this.status});

  factory Exchange.fromJson(Map<String, dynamic> json) =>
      _$ExchangeArticleFromJson(json);

  Exchange.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.ecocard = map['ecocard'];
    this.point = map['point'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ecocard': this.ecocard,
      'point': this.point,
      'status': this.status
    };
  }
}
