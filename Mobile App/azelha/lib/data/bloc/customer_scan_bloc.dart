import 'dart:convert';

import 'package:azelha/data/model/scan_model.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:rxdart/rxdart.dart';

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'base_bloc.dart';

class CustomerScanBloc extends BaseBloc {
  static CustomerScanBloc _instance = CustomerScanBloc._internal();
  var _isLoading = false;
  getLoading() => _isLoading;

  BehaviorSubject<List<Scan>> upComingScanController =
      new BehaviorSubject<List<Scan>>();
  BehaviorSubject<List<Scan>> pastScanController =
      new BehaviorSubject<List<Scan>>();

  factory CustomerScanBloc() {
    if (_instance == null) return _instance = CustomerScanBloc._internal();
    return _instance;
  }

  CustomerScanBloc._internal() {
    upComingScanController = new BehaviorSubject();
    pastScanController = new BehaviorSubject();
  }

  void initPastScanByStatusData(int id, String status1, String status2) async {
    var _res = await apiHelper.getWithoutAuth(ApiEndpoint.customerScans +
        id.toString() +
        "/" +
        status1 +
        "/" +
        status2);
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.isSuccess) {
      ScanModel _model =
          ScanModel.fromJson(json.decode(_networkResponse.response.body));
      pastScanController.add(_model.scanList);
      print("the value of scan is" + _networkResponse.response.body);
    } else {
      print("Some error");
    }
    _isLoading = false;
    notifyListeners();
  }

  void initUpComScanByStatusData(int id, String status1, String status2) async {
    var _res = await apiHelper.getWithoutAuth(ApiEndpoint.customerScans +
        id.toString() +
        "/" +
        status1 +
        "/" +
        status2);
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.isSuccess) {
      ScanModel _model =
          ScanModel.fromJson(json.decode(_networkResponse.response.body));
      upComingScanController.add(_model.scanList);
      print("the value of scan is" + _networkResponse.response.body);
    } else {
      print("Some error");
    }
    _isLoading = false;
    notifyListeners();
  }

  void setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  @override
  // ignore: must_call_super
  void dispose() {
    upComingScanController.close();
    pastScanController.close();
  }
}
