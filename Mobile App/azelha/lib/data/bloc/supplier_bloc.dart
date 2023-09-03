import 'dart:convert';

import 'package:azelha/data/model/supplier_model.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:rxdart/rxdart.dart';

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'base_bloc.dart';

class SupplierBloc extends BaseBloc {
  static SupplierBloc _instance = SupplierBloc._internal();

  BehaviorSubject<Supplier> supplierController;

  factory SupplierBloc() {
    if (_instance == null) return _instance = SupplierBloc._internal();
    return _instance;
  }

  SupplierBloc._internal() {
    supplierController = new BehaviorSubject();
    initSupplierData(1);
  }

  Future initSupplierData(int id) async {
    var _res = await apiHelper
        .getWithoutAuth(ApiEndpoint.supplierById + id.toString());

    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.isSuccess) {
      Supplier _model =
          Supplier.fromJson(json.decode(_networkResponse.response.body));
      supplierController.sink.add(_model);
    } else {
      print("Some error");
    }
  }

  @override
  void dispose() {
    supplierController.close();
  }
}
