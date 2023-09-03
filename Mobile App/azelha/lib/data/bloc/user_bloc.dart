import 'dart:convert';

import 'package:azelha/contsants/network_util.dart';
import 'package:azelha/data/model/user_model.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'base_bloc.dart';

class UserBloc extends BaseBloc {
  static UserBloc _instance = UserBloc._internal();

  BehaviorSubject<User> userController;

  factory UserBloc() {
    if (_instance == null) return _instance = UserBloc._internal();
    return _instance;
  }

  UserBloc._internal() {
    userController = new BehaviorSubject();
  }

  Future initUserData(String email) async {
    User _model;
    http.Response _res = await apiHelper
        .getWithoutAuth(ApiEndpoint.userEmail + email.toString());
    if (NetworkUtil.isReqSuccess(
      tag: "response",
      response: _res,
    )) {
      _model = User.fromJson(json.decode(_res.body));
      userController.sink.add(_model);
      return _model;
    } else {
      print("Some error");
    }
  }

  Future addCustomerOrder(User user) async {
    print("the new Customer is" + user.toMap().toString());
    var _res = await apiHelper.postWithoutAuth2(
        ApiEndpoint.newCustomer, jsonEncode(user.toMap()));
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);

    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Something went wrong. Please try again");
    } else {
      User _model = User.fromJson(json.decode(_networkResponse.response.body));
      userController.sink.add(_model);
      print("the value of order is " + _networkResponse.response.body);
    }
  }

  Future logout(int id) async {
    var _res =
        await apiHelper.getWithoutAuth(ApiEndpoint.logout2 + id.toString());
    notifyListeners();
    return _res.body;
  }

  @override
  // ignore: must_call_super
  void dispose() {
    userController.close();
  }
}
