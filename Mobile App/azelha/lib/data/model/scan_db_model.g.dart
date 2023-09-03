part of 'scan_db_model.dart';

ScanItemDB _$ScanItemDBFromJson(Map<String, dynamic> json) {
  return ScanItemDB(
    id: json['id'] as int,
    barcode_number: json['barcode_number'] as String,
    barcode_type: json['barcode_type'] as String,
    barcode_formats: json['barcode_formats'] as String,
    mpn: json['mpn'] as String,
    model: json['model'] as String,
    asin: json['asin'] as String,
    package_quantity: json['package_quantity'] as String,
    size: json['size'] as String,
    length: json['length'] as String,
    width: json['width'] as String,
    height: json['height'] as String,
    weight: json['weight'] as String,
    description: json['description'] as String,
    image: json['image'] as String,
    points: json['points'] as int,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$ScanItemDBToJson(ScanItemDB instance) =>
    <String, dynamic>{
      'id': instance.id,
      'barcode_number': instance.barcode_number,
      'barcode_type': instance.barcode_type,
      'barcode_formats': instance.barcode_formats,
      'mpn': instance.mpn,
      'model': instance.model,
      'asin': instance.asin,
      'package_quantity': instance.package_quantity,
      'size': instance.size,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
      'weight': instance.weight,
      'description': instance.description,
      'image': instance.image,
      'points': instance.points,
      'status': instance.status
    };
