import 'package:json_annotation/json_annotation.dart';

part 'eco_card_model.g.dart';

class EcoCardModel {
  List<EcoCard> ecoCardList;

  EcoCardModel._internal(this.ecoCardList);

  factory EcoCardModel.fromJson(dynamic json) {
    return EcoCardModel.fromMapList(list: json as List);
  }

  factory EcoCardModel.fromMapList({List<dynamic> list}) {
    final items =
    list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return EcoCard.fromMap(item);
    }).toList();

    return EcoCardModel._internal(items);
  }
}

@JsonSerializable()
class EcoCard {
  int id;
  Map<String, dynamic> user;
  String ecoCardNum;
  String expDate;
  String cardHolderName;
  String cvv;
  bool isActive;
  String ecoCardType;

  EcoCard(
      {this.id,
        this.user,
        this.ecoCardNum,
        this.expDate,
        this.cardHolderName,
        this.cvv,
        this.isActive,
        this.ecoCardType});

  factory EcoCard.fromJson(Map<String, dynamic> json) =>
      _$EcoCardFromJson(json);

  EcoCard.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.ecoCardNum = map['ecoCardNum'];
    this.expDate = map['expDate'];
    this.cardHolderName = map['cardHolderName'];
    this.ecoCardType = map['ecoCardType'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this.id,
      'user': this.user,
      'ecoCardNum': this.ecoCardNum,
      'expDate': this.expDate,
      'cardHolderName': this.cardHolderName,
      'cvv': this.cvv,
      'isActive': this.isActive,
      'ecoCardType': this.ecoCardType
    };
  }
}
