import 'dart:convert';

import 'package:azelha/data/model/product_model.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:rxdart/rxdart.dart';

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'base_bloc.dart';

class ProductBloc extends BaseBloc {
  static ProductBloc _instance = ProductBloc._internal();
  BehaviorSubject<List<Product>> productListSubject;
  BehaviorSubject<List<Product>> _productListSearchSubject;
  BehaviorSubject<List<Product>> _productFavoriteSubject;
  BehaviorSubject<Product> productSubject;
  bool isReplay = false;
  factory ProductBloc() {
    if (_instance == null) return _instance = ProductBloc._internal();
    return _instance;
  }

  get productListStream => productListSubject.stream;
  get productListSearchStream => _productListSearchSubject.stream;
  get productFavoriteStream => _productFavoriteSubject.stream;
  get productStream => productSubject.stream;
  ProductBloc._internal() {
    productListSubject = new BehaviorSubject();
    _productListSearchSubject = new BehaviorSubject();
    _productFavoriteSubject = new BehaviorSubject();
    productSubject = new BehaviorSubject();
    getAllData();
  }

  void initDataByCategoryId(int id) async {
    var _res = await apiHelper
        .getWithoutAuth(ApiEndpoint.productListByCategory + id.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      ProductModel _model =
          ProductModel.fromJson(json.decode(_networkResponse.response.body));
      productListSubject.sink.add(_model.list);
    }
  }

  void initDataByCompanyId(int id) async {
    var _res = await apiHelper
        .getWithoutAuth(ApiEndpoint.productsByCompany + id.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      ProductModel _model =
          ProductModel.fromJson(json.decode(_networkResponse.response.body));
      productListSubject.sink.add(_model.list);
    }
  }

  Future<Product> getProductById(id) async {
    Product _model;
    var _res =
        await apiHelper.getWithoutAuth(ApiEndpoint.productList + id.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      _model = Product.fromJson(json.decode(_networkResponse.response.body));
      productSubject.sink.add(_model);
      print("the value is " + _networkResponse.response.body);
    }
    return _model;
  }

  Future<Product> getProductByBarCode(code) async {
    Product _model;
    var _res = await apiHelper
        .getWithoutAuth(ApiEndpoint.productBarCode + code.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      _model = Product.fromJson(json.decode(_networkResponse.response.body));
      productSubject.sink.add(_model);
      print("the value is " + _networkResponse.response.body);
    }
    return _model;
  }

  Future<List<Product>> getAllData() async {
    ProductModel _model;
    var _res = await apiHelper.getWithoutAuth(ApiEndpoint.productList);
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      _model =
          ProductModel.fromJson(json.decode(_networkResponse.response.body));
      productListSubject.sink.add(_model.list);
    }
    return _model.list;
  }

  Future<List<Product>> getAllProductsByName(String searchTerm) async {
    await Future.delayed(Duration(seconds: searchTerm.length == 4 ? 10 : 1));
    ProductModel _model;
    var _res =
        await apiHelper.getWithoutAuth(ApiEndpoint.searchTerm + searchTerm);
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      _model =
          ProductModel.fromJson(json.decode(_networkResponse.response.body));
      _productListSearchSubject.sink.add(_model.list);
    }
    return _model.list;
  }

  Future<List<Product>> getFavoriteProducts() async {
    ProductModel _model;
    var _res = await apiHelper.getWithoutAuth(ApiEndpoint.getFavorite + "true");
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      _model =
          ProductModel.fromJson(json.decode(_networkResponse.response.body));
      _productFavoriteSubject.sink.add(_model.list);
    }
    return _model.list;
  }

  void toggleFavorite(int id, String isFavorite) async {
    Map<String, String> map = new Map();
    map.putIfAbsent("isFavorite", () => isFavorite);

    var _res = await apiHelper.putWithoutAuth(
        ApiEndpoint.toggleFavorite + id.toString(), jsonEncode(map));
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      ProductModel _model =
          ProductModel.fromJson(json.decode(_networkResponse.response.body));
      productListSubject.sink.add(_model.list);
    }
  }

  @override
  // ignore: must_call_super
  void dispose() {
    productListSubject.close();
    _productListSearchSubject.close();
    _productFavoriteSubject.close();
    productSubject.close();
  }
}
