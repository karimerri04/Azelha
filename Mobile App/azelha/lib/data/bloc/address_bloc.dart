import 'dart:convert';

import 'package:azelha/data/model/address_model.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:rxdart/rxdart.dart';

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'base_bloc.dart';

class AddressBloc extends BaseBloc {
  static AddressBloc _instance = AddressBloc._internal();
  BehaviorSubject<List<Addresss>> addressListController;
  BehaviorSubject<Addresss> addressController;
  factory AddressBloc() {
    // ignore: unnecessary_null_comparison
    if (_instance == null) return _instance = AddressBloc._internal();
    return _instance;
  }

  AddressBloc._internal() {
    addressController = new BehaviorSubject();
    addressListController = new BehaviorSubject();
  }

  Future initAddressData(int id) async {
    var _res =
        await apiHelper.getWithoutAuth(ApiEndpoint.addressUser + id.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.isSuccess) {
      Addresss _model =
          Addresss.fromJson(json.decode(_networkResponse.response.body));
      addressController.sink.add(_model);
    } else {
      print("Some error");
    }
  }

  Future initAddressByCompanyId(int id) async {
    var _res = await apiHelper
        .getWithoutAuth(ApiEndpoint.addressCompany + id.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.isSuccess) {
      AddressModel _model =
          AddressModel.fromJson(json.decode(_networkResponse.response.body));
      addressListController.sink.add(_model.addressList);
    } else {
      print("Some error");
    }
  }

  Future upDateAddressStatus(int id) async {
    var _res = await apiHelper.putWithoutAuth(
        ApiEndpoint.updateAddressStatus, id.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      addressController.sink.done;
    }
    notifyListeners();
  }

  Future addAddressOrder(Addresss address) async {
    var _res = await apiHelper.postWithoutAuth2(
        ApiEndpoint.newAddress, jsonEncode(address.toMap()));
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Something went wrong. Please try again");
    } else {
      Addresss _model =
          Addresss.fromJson(json.decode(_networkResponse.response.body));
      addressController.sink.add(_model);
      print("the value of address is " + _networkResponse.response.body);
    }
  }

  @override
  // ignore: must_call_super
  void dispose() {
    addressController.close();
    addressListController.close();
  }
}
