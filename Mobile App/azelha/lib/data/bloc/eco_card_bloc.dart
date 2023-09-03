import 'dart:convert';

import 'package:azelha/data/model/eco_card_model.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:rxdart/rxdart.dart';

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'base_bloc.dart';

class EcoCardBloc extends BaseBloc {
  static EcoCardBloc _instance = EcoCardBloc._internal();

  BehaviorSubject<EcoCard> creditCartController;
  BehaviorSubject<List<EcoCard>> creditCartControllerList;
  factory EcoCardBloc() {
    if (_instance == null) return _instance = EcoCardBloc._internal();
    return _instance;
  }

  EcoCardBloc._internal() {
    creditCartController = new BehaviorSubject();
    creditCartControllerList = new BehaviorSubject();
  }

  Future getActiveEcoCardData(int id) async {
    var _res = await apiHelper
        .getWithoutAuth(ApiEndpoint.ecoCardExchange + id.toString() + "/true");
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.isSuccess) {
      EcoCard _model =
          EcoCard.fromJson(json.decode(_networkResponse.response.body));
      creditCartController.sink.add(_model);
    } else {
      print("Some error");
    }
  }

  Future getAllCard(int id) async {
    var _res =
        await apiHelper.getWithoutAuth(ApiEndpoint.ecoCards + id.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      EcoCardModel _model =
          EcoCardModel.fromJson(json.decode(_networkResponse.response.body));
      creditCartControllerList.sink.add(_model.ecoCardList);
      print("the value is " + _networkResponse.response.body);
    }
  }

  Future addCreditCardOrder(EcoCard creditCard) async {
    var _res = await apiHelper.postWithoutAuth2(
        ApiEndpoint.newCreditCard, jsonEncode(creditCard.toMap()));
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);

    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Something went wrong. Please try again");
    } else {
      EcoCard _model =
          EcoCard.fromJson(json.decode(_networkResponse.response.body));
      creditCartController.sink.add(_model);
      print("the value of order is " + _networkResponse.response.body);
    }
  }

  Future submitCard(String paymentToken, double totalAmount) async {
    Map<String, dynamic> payload = new Map();
    payload.putIfAbsent('token', () => paymentToken);
    payload.putIfAbsent('amount', () => totalAmount);
    var _res = await apiHelper.postWithoutAuth2(
        ApiEndpoint.chargePayment, jsonEncode(payload));
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Something went wrong. Please try again");
    } else {
      print("the value of order is " + _networkResponse.response.body);
    }
  }

  @override
  void dispose() {
    creditCartController.close();
    creditCartControllerList.close();
  }
}
