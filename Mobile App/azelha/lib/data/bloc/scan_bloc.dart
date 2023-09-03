import 'dart:convert';

import 'package:azelha/data/model/scan_model.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:rxdart/rxdart.dart';

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'base_bloc.dart';

class ScanBloc extends BaseBloc {
  static ScanBloc _instance = ScanBloc._internal();
  BehaviorSubject<List<Scan>> scanListSubject = new BehaviorSubject();

  factory ScanBloc() {
    if (_instance == null) return _instance = ScanBloc._internal();
    return _instance;
  }
  ScanBloc._internal() {
    scanListSubject = new BehaviorSubject();
  }
  //get scanListStream => _scanListSubject.stream;

  Future initData(int id) async {
    var _res =
        await apiHelper.getWithoutAuth(ApiEndpoint.scanList + id.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      ScanModel _model =
          ScanModel.fromJson(json.decode(_networkResponse.response.body));
      scanListSubject.sink.add(_model.scanList);
      print("the value is " + _networkResponse.response.body);
    }
  }

  Future cancelScan(Scan scan) async {
    var _res = await apiHelper.putWithoutAuth(
        ApiEndpoint.scanUpdate, scan.id.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      scanListSubject.sink.done;
    }
    notifyListeners();
  }

  Future getArticlesScanById(int id) async {
    var _res = (await apiHelper
        .getWithoutAuth(ApiEndpoint.articleByScanId + id.toString()));
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.isSuccess) {
      ScanModel _model =
          ScanModel.fromJson(json.decode(_networkResponse.response.body));
      scanListSubject.sink.add(_model.scanList);
    } else {
      print("Some error");
    }
  }

  Future getAllData() async {
    var _res = await apiHelper.getWithoutAuth(ApiEndpoint.scanList);
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      ScanModel _model =
          ScanModel.fromJson(json.decode(_networkResponse.response.body));
      scanListSubject.sink.add(_model.scanList);
      print("the value is " + _networkResponse.response.body);
    }
  }

  Future getScansByCostumer(id) async {
    var _res = await apiHelper
        .getWithoutAuth(ApiEndpoint.articleScanList + id.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      ScanModel _model =
          ScanModel.fromJson(json.decode(_networkResponse.response.body));
      scanListSubject.sink.add(_model.scanList);
      print("the value is " + _networkResponse.response.body);
    }
  }

  Future addCustomerScan(Scan scan) async {
    var _res = await apiHelper.postWithoutAuth2(
        ApiEndpoint.scanNew, jsonEncode(scan.toMap()));
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);

    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Something went wrong. Please try again");
    } else {
      ScanModel _model =
          ScanModel.fromJson(json.decode(_networkResponse.response.body));
      scanListSubject.sink.add(_model.scanList);
      print("the value of scan is " + _networkResponse.response.body);
    }
  }

  @override
  void dispose() {
    scanListSubject.close();
  }
}
