import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

SharedPrefsHelper prefsHelper = new SharedPrefsHelper();

class SharedPrefsHelper {
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();

  SharedPreferences _prefs;

  final String PREFS_TOKEN = "TOKEN";
  final String REFRSH_TOKEN = "REFESHTOKEN";
  final String PREFS_IS_LOGIN = "ISLOGIN";
  final String PREFS_EMAIL = "EMAIL";
  final String PREFS_PASSWORD = "PASSWORD";
  final String PREFS_SUBTOTAL = "SUBTOTAL";
  final String PREFS_ITEMS = "ITEMS";
  final String COMPANY_ITEMS = "COMITEMS";
  final String CAT_ITEMS = "PRODITEMS";
  final String PHONE = "PHONE";
  final String SCREEN = "SCREEN";
  final String ADDRESS = "ADDRESS";

  set token(value) => _prefs.setString(PREFS_TOKEN, value);
  get token => _prefs.getString(PREFS_TOKEN) ?? "default value";

  set refreshToken(value) => _prefs.setString(REFRSH_TOKEN, value);
  get refreshToken => _prefs.getString(REFRSH_TOKEN) ?? "default value";

  set isLogin(value) => _prefs.setBool(PREFS_IS_LOGIN, value);
  get isLogin => _prefs.getBool(PREFS_IS_LOGIN) ?? false;

  set email(value) => _prefs.setString(PREFS_EMAIL, value);
  get email => _prefs.getString(PREFS_EMAIL) ?? "default value";

  set password(value) => _prefs.setString(PREFS_PASSWORD, value);
  get password => _prefs.getString(PREFS_PASSWORD) ?? "default value";

  set subTotal(value) => _prefs.setDouble(PREFS_SUBTOTAL, value);
  get subTotal => _prefs.getDouble(PREFS_SUBTOTAL) ?? 0.0;

  set numberItems(value) => _prefs.setString(PREFS_ITEMS, value);
  get numberItems => _prefs.getString(PREFS_ITEMS) ?? "default value";

  set companyValue(value) => _prefs.setString(COMPANY_ITEMS, value);
  get companyValue => _prefs.getString(COMPANY_ITEMS) ?? "default value";

  set categoryValue(value) => _prefs.setString(CAT_ITEMS, value);
  get categoryValue => _prefs.getString(CAT_ITEMS) ?? "default value";

  set phone(value) => _prefs.setString(PHONE, value);
  get phone => _prefs.getString(PHONE) ?? "0000000";

  set screen(value) => _prefs.setString(SCREEN, value);
  get screen => _prefs.getString(SCREEN) ?? "default value";

  set address(value) => _prefs.setString(ADDRESS, value);
  get address => _prefs.getString(ADDRESS) ?? "default value";

  factory SharedPrefsHelper() {
    return _instance;
  }

  SharedPrefsHelper._internal();

  Future<SharedPreferences> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  void checkIsInitialize() {
    assert(_prefs != null,
    "Call prefsHelper.initialize first before using Shared Prefs");
  }

  void clear() {
    _prefs.clear();
  }
}
