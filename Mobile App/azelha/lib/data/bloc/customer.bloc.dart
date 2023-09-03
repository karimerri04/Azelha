import 'dart:convert';

import 'package:azelha/data/model/customer_model.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:rxdart/rxdart.dart';

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'base_bloc.dart';

class CustomerBloc extends BaseBloc {
  static CustomerBloc _instance = CustomerBloc._internal();

  BehaviorSubject<List<Customer>> customersController;
  BehaviorSubject<Customer> customerController;

  factory CustomerBloc() {
    if (_instance == null) return _instance = CustomerBloc._internal();
    return _instance;
  }

  CustomerBloc._internal() {
    customersController = new BehaviorSubject();
    customerController = new BehaviorSubject();
  }

  Future initCustomerData(int id) async {
    var _res = await apiHelper
        .getWithoutAuth(ApiEndpoint.customerUser + id.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.isSuccess) {
      CustomerModel _model =
          CustomerModel.fromJson(json.decode(_networkResponse.response.body));
      customersController.sink.add(_model.list);
    } else {
      print("Some error");
    }
  }

  Future addCustomerOrder(Customer customer) async {
    print("the new Customer is" + customer.toMap().toString());
    var _res = await apiHelper.postWithoutAuth2(
        ApiEndpoint.newCustomer, jsonEncode(customer.toMap()));
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);

    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Something went wrong. Please try again");
    } else {
      CustomerModel _model =
          CustomerModel.fromJson(json.decode(_networkResponse.response.body));
      customersController.sink.add(_model.list);
      print("the value of order is " + _networkResponse.response.body);
    }
  }

  @override
  // ignore: must_call_super
  // ignore: must_call_super
  void dispose() {
    customersController.close();
    customerController.close();
  }
}
