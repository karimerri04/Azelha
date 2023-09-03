import 'dart:convert';

import 'package:azelha/data/model/category_model.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:rxdart/rxdart.dart';

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'base_bloc.dart';

class CategoryBloc extends BaseBloc {
  static CategoryBloc _instance = CategoryBloc._internal();

  BehaviorSubject<List<Category>> categoryController;

  factory CategoryBloc() {
    if (_instance == null) return _instance = CategoryBloc._internal();
    return _instance;
  }

  CategoryBloc._internal() {
    categoryController = new BehaviorSubject();
    initCategoryData();
  }

  Future initCategoryData() async {
    CategoryModel _model;
    var _res = await apiHelper.getWithoutAuth(ApiEndpoint.categoryList);
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      _model =
          CategoryModel.fromJson(json.decode(_networkResponse.response.body));
      categoryController.sink.add(_model.categoryList);
      print("the value is " + _networkResponse.response.body);
    }
    return _model.categoryList;
  }

  @override
  void dispose() {
    categoryController.close();
  }
}
