part of 'scan_model.dart';

Scan _$ScanFromJson(Map<String, dynamic> json) {
  return Scan(
      id: json['id'] as int,
      scanNumber: json['scanNumber'] as String,
      scanDate: json['scanDate'] as String,
      checkoutComment: json['checkoutComment'] as String,
      status: json['status'] as String);
}

Map<String, dynamic> _$ScanToJson(Scan instance) => <String, dynamic>{
      'id': instance.id,
      'scanNumber': instance.scanNumber,
      'scanDate': instance.scanDate,
      'checkoutComment': instance.checkoutComment,
      'status': instance.status
    };
