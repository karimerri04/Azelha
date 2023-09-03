import 'package:json_annotation/json_annotation.dart';

part 'scan_model.g.dart';

class ScanModel {
  List<Scan> scanList;

  ScanModel._internal(this.scanList);

  factory ScanModel.fromJson(dynamic json) {
    return ScanModel.fromMapList(list: json as List);
  }

  factory ScanModel.fromMapList({List<dynamic> list}) {
    final items =
        list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return Scan.fromMap(item);
    }).toList();

    return ScanModel._internal(items);
  }
}

@JsonSerializable()
class Scan {
  int id;
  String scanNumber;
  String scanDate;
  String checkoutComment;
  String status;
  Map<String, dynamic> customer;
  Map<String, dynamic> address;
  List<dynamic> articles;
  Map<String, dynamic> exchange;
  Map<String, dynamic> supplier;

  Scan({
    this.id,
    this.scanNumber,
    this.scanDate,
    this.checkoutComment,
    this.status,
    this.customer,
    this.address,
    this.articles,
    this.exchange,
    this.supplier,
  });

  Scan.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.scanNumber = map['scanNumber'];
    this.scanDate = map['scanDate'];
    this.customer = map['customer'];
    this.address = map['address'];
    this.checkoutComment = map['checkoutComment'];
    this.status = map['status'];
    this.articles = map['articles'];
    this.exchange = map['exchange'];
    this.supplier = map['supplier'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'scanNumber': this.scanNumber,
      'scanDate': this.scanDate,
      'checkoutComment': this.checkoutComment,
      'status': this.status,
      'customer': this.customer,
      'address': this.address,
      'articles': this.articles,
      'exchange': this.exchange,
      'supplier': this.supplier,
    };
  }

  factory Scan.fromJson(Map<String, dynamic> json) => _$ScanFromJson(json);
}
