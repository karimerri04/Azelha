part of 'eco_card_model.dart';

EcoCard _$EcoCardFromJson(Map<String, dynamic> json) {
  return EcoCard(
      id: json['id'] as int,
      user: json['user'] as Map<String, dynamic>,
      ecoCardNum: json['ecoCardNum'] as String,
      expDate: json['expDate'] as String,
      cardHolderName: json['cardholderName'] as String,
      cvv: json['cvv'] as String,
      isActive: json['isActive'] as bool,
      ecoCardType: json['ecoCardType'] as String);
}

Map<String, dynamic> _$EcoCardToJson(EcoCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'ccNum': instance.ecoCardNum,
      'expDate': instance.expDate,
      'cardHolderName': instance.cardHolderName,
      'cvv': instance.cvv,
      'isActive': instance.isActive,
      'ecoCardType': instance.ecoCardType
    };
