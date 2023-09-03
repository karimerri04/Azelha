part of 'supplier_model.dart';

Supplier _$SupplierItemFromJson(Map<String, dynamic> json) {
  return Supplier(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    status: json['status'] as bool,
    logo: json['logo'] as String,
  );
}

Map<String, dynamic> _$SupplierItemToJson(Supplier instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'logo': instance.logo
    };
