import 'dart:async';
import 'dart:convert' show JsonDecoder, json, utf8;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'auth_exception.dart';

class NetworkUtil {
  var httpClient = new HttpClient();
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();
  Future<dynamic> get(String url) {
    return http.get(url).then((Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> get2(Uri url) async {
    HttpClientRequest request = await httpClient.getUrl(url)
      ..headers.add(HttpHeaders.ACCEPT, ContentType.JSON)
      ..headers.contentType = ContentType.JSON
      ..headers.chunkedTransferEncoding = false;
    HttpClientResponse response = await request.close();

    if (response.headers.contentType.toString() !=
        ContentType.JSON.toString()) {
      throw new UnsupportedError('Server returned an unsupported content type: '
          '${response.headers.contentType} from ${request.uri}');
    }
    if (response.statusCode != HttpStatus.OK) {
      throw new StateError(
          'Server responded with error: ${response.statusCode} ${response.reasonPhrase}');
    }

    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      if (statusCode == 401) {
        throw new AuthenticationException("401 Unauthorized at $url");
      } else {
        throw new Exception("Error while fetching data");
      }
    }
    return json.decode(await response.transform(utf8.decoder).join());
  }

  static isReqSuccess(
      {@required String tag, @required http.Response response}) {
    print("Network Request: " +
        tag +
        ": " +
        "ResponseBody: " +
        response.body.toString());
    if (response.statusCode < 200 || response.statusCode >= 300) {
      print("Network Request: " +
          tag +
          ": " "ResponseErrorCode: " +
          response.statusCode.toString());
      return false;
    } else {
      return true;
    }
  }

  void post() {
    //TODO implementation
  }

  void put() {
    //TODO implementation
  }

  void delete() {
    //TODO implementation
  }
}
