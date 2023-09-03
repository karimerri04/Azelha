import 'package:json_annotation/json_annotation.dart';

part 'scan_db_model.g.dart';

class ScanDBModel {
  List<ScanItemDB> scanItemDBList;

  ScanDBModel._internal(this.scanItemDBList);

  factory ScanDBModel.fromJson(dynamic json) {
    return ScanDBModel.fromMapList(list: json as List);
  }

  // Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  factory ScanDBModel.fromMapList({List<dynamic> list}) {
    final items =
        list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return ScanItemDB.fromMap(item);
    }).toList();

    return ScanDBModel._internal(items);
  }
}

@JsonSerializable()
class ScanItemDB {
  int id;
  String barcode_number;
  String barcode_type;
  String barcode_formats;
  String mpn;
  String model;
  String asin;
  String package_quantity;
  String size;
  String length;
  String width;
  String height;
  String weight;
  String description;
  String image;
  int points;
  String status;

  ScanItemDB({
    this.id,
    this.barcode_number,
    this.barcode_type,
    this.barcode_formats,
    this.mpn,
    this.model,
    this.asin,
    this.package_quantity,
    this.size,
    this.length,
    this.width,
    this.height,
    this.weight,
    this.description,
    this.image,
    this.points,
    this.status,
  });

  ScanItemDB.fromMap(Map<String, dynamic> map) {
    this.id = map['_id'];
    this.barcode_number = map['barcode_number'];
    this.barcode_type = map['barcode_type'];
    this.barcode_formats = map['barcode_formats'];
    this.mpn = map['mpn'];
    this.model = map['model'];
    this.asin = map['asin'];
    this.package_quantity = map['package_quantity'];
    this.size = map['size'];
    this.length = map['length'];
    this.width = map['width'];
    this.height = map['height'];
    this.weight = map['weight'];
    this.description = map['description'];
    this.image = map['image'];
    this.points = map['points'];
    this.status = map['status'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': this.id,
      'barcode_number': this.barcode_number,
      'barcode_type': this.barcode_type,
      'barcode_formats': this.barcode_formats,
      'mpn': this.mpn,
      'model': this.model,
      'asin': this.asin,
      'package_quantity': this.package_quantity,
      'size': this.size,
      'length': this.length,
      'width': this.width,
      'height': this.height,
      'weight': this.weight,
      'description': this.description,
      'image': this.image,
      'points': this.points,
      'status': this.status,
    };
  }
}
