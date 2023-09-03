import 'dart:convert';

import 'package:azelha/data/model/article_model.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:rxdart/rxdart.dart';

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'base_bloc.dart';

class ArticleBloc extends BaseBloc {
  static ArticleBloc _instance = ArticleBloc._internal();

  BehaviorSubject<List<Article>> articleController;
  factory ArticleBloc() {
    if (_instance == null) return _instance = ArticleBloc._internal();
    return _instance;
  }

  ArticleBloc._internal() {
    articleController = new BehaviorSubject();
  }

  Future getArticleByScanId(id) async {
    ArticleModel _model;
    var _res = await apiHelper
        .getWithoutAuth(ApiEndpoint.articleByScanId + id.toString());
    NetworkResponse _networkResponse = apiHelper.parseResponse(_res);
    if (_networkResponse.statusCode < 200 ||
        _networkResponse.statusCode >= 300) {
      print("Some error");
    } else {
      _model =
          ArticleModel.fromJson(json.decode(_networkResponse.response.body));
      articleController.sink.add(_model.articleList);
      print("the value is " + _networkResponse.response.body);
    }
    return _model.articleList;
  }

  @override
  // ignore: must_call_super
  void dispose() {
    articleController.close();
  }
}
