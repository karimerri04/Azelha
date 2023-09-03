import 'dart:async';
import 'dart:convert';

import 'package:azelha/contsants/shared_prefs_helper.dart';
import 'package:cryptoutils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

ApiHelper apiHelper = new ApiHelper();

class ApiHelper {
  // static const baseUrl = "http://10.0.2.2:5000/api";
  static const baseUrl = "http://192.168.1.101:5000/api";

  // static const baseUrl = "http://aladinapi-env.eba-zxhmcfpg.us-east-2.elasticbeanstalk.com/api";

  SharedPreferences preferences;
  ApiHelper _apiHelper;
  Map<String, String> headers = {};
  static final ApiHelper _instance = new ApiHelper._internal();
  String token;
  String phone;
  String email;
  String refreshToken;
  String invalidToken;
  bool isToken = false;

  factory ApiHelper() {
    return _instance;
  }

  ApiHelper._internal();

  Map<String, dynamic> payload = new Map();

  Future<ApiHelper> initialize() async {
    token = prefsHelper.token;
    refreshToken = prefsHelper.refreshToken;
    phone = prefsHelper.phone;
    email = prefsHelper.email;
    if (token != null && token.isNotEmpty) {
      isToken = true;
    } else if (invalidToken != null && invalidToken.isNotEmpty) {
      isToken = false;
    }
    payload.putIfAbsent('username', () => prefsHelper.email);
    payload.putIfAbsent('password', () => prefsHelper.password);
    payload.putIfAbsent('grant_type', () => "password");
    return _apiHelper;
  }

  // Without auth
  Future<http.Response> getWithoutAuth(String url) async {
    return await http.get(baseUrl + url);
  }

/*  Future<http.Response> postWithoutAuth(
      String url, Map<String, dynamic> body) async {
    Map<String, String> headers = new Map();
    headers.putIfAbsent('Content-Type',
        () => 'application/x-www-form-urlencoded; charset=utf-8');
    headers.putIfAbsent('Authorization',
        () => createBasicAuthToken('my-trusted-client-password:secret'));
    headers.putIfAbsent('client_id', () => "my-trusted-client-password");
    headers.putIfAbsent('client_secret', () => "secret");
    headers.putIfAbsent('scope', () => "");
    http.Response response =
        await http.post(baseUrl + url, body: body, headers: headers);
    updateCookie(response);
    return await http.post(baseUrl + url, body: body, headers: headers);

  }*/

  Future<http.Response> putWithoutAuth(String url, String body) async {
    Map<String, String> map = new Map();
    map.putIfAbsent("Content-Type", () => "application/json");
    return await http.put(baseUrl + url, body: body, headers: map);
  }

  // With auth
/*  Future<http.Response> postWitAuth(String url, String body) async {
    http.Response response = await http.post(baseUrl + url,
        body: body, headers: getAuthTokenHeader());
    return response;
  }*/

  Future<http.Response> postWithoutAuth2(String url, String body) async {
    Map<String, String> _map = new Map();
    _map.putIfAbsent("Content-Type", () => "application/json");
    http.Response response =
        await http.post(baseUrl + url, body: body, headers: _map);
    return response;
  }

/*  Future<http.Response> putWitAuth(String url, String body) async {
    http.Response response = await http.put(baseUrl + url,
        body: body, headers: getAuthTokenHeader());
    return response;
  }*/

/*  Future<http.Response> putWitAuth2({String endpoint}) async {
    http.Response response =
        await http.put(baseUrl + endpoint, headers: getAuthTokenHeader());
    return response;
  }*/

/*  Future<http.Response> getWithAuth({String endpoint}) async {
    return await http.get(baseUrl + endpoint, headers: getAuthTokenHeader());
  }*/

/*  Future<http.Response> getWithAuth2({String endpoint}) async {
    return await http.get(baseUrl + endpoint,
        headers: getRefreshAuthTokenHeader());
  }*/

/*  Future<NetworkResponse> getWithAuth1({String endpoint}) async {
    var _raw =
        await http.get(baseUrl + endpoint, headers: getAuthTokenHeader());
    return parseResponse(_raw);
  }*/

  createBasicAuthToken(str) {
    var bytes = utf8.encode(str);
    var base64 = CryptoUtils.bytesToBase64(bytes);
    return 'Basic ' + base64;
  }

  createBasicAuthToken2(str) {
    return 'Basic ' + str;
  }

  responseBody(var resp) async {
    invalidToken = jsonDecode(resp.body)["invalid_token"];
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

/*  Map<String, String> getAuthTokenHeader() {
    Map<String, String> _map = new Map();
    _map.putIfAbsent("Content-Type", () => "application/json");
    _map.putIfAbsent("Authorization", () => "Bearer " + token);
    return _map;
  }*/

  Map<String, String> getRefreshAuthTokenHeader() {
    Map<String, String> _map = new Map();
    _map.putIfAbsent("Content-Type", () => "application/json");
    _map.putIfAbsent("Authorization", () => "Bearer " + refreshToken);
    return _map;
  }

  NetworkResponse parseResponse(http.Response response) {
    print("NetworkReq URL: " + response.request.url.toString());
    print("NetworkReq STATUS: " + response.statusCode.toString());
    print("NetworkReq BODY: " + response.body.toString());
    return NetworkResponse(response);
  }

  void getLocationData() {}
}

class NetworkResponse {
  http.Response response;
  int statusCode;
  bool isSuccess;
  String message;

  NetworkResponse(this.response) {
    this.statusCode = response.statusCode;
    this.message = response.body;
    if (response.statusCode < 200 || response.statusCode >= 300) {
      this.isSuccess = false;
    } else
      this.isSuccess = true;
  }
}
