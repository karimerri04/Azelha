import 'dart:convert';

import 'package:azelha/contsants/network_util.dart';
import 'package:azelha/contsants/shared_prefs_helper.dart';
import 'package:azelha/contsants/snackbar_utils.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'login.dart';
import 'verification_code_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String fullName, email, phone, password;
  final _key = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _secureText = true;

  @override
  void initState() {
    super.initState();
    saveScreenPref('register');
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    Map<String, dynamic> payload = new Map();
    payload.putIfAbsent('username', () => "admin@default.com");
    payload.putIfAbsent('password', () => "admin");
    payload.putIfAbsent('grant_type', () => "password");

    http.Response response1 = await apiHelper.postWithoutAuth2(
        ApiEndpoint.getToken, jsonEncode(payload));
    if (NetworkUtil.isReqSuccess(
      tag: "access_token",
      response: response1,
    )) {
      String token = jsonDecode(response1.body)["access_token"];
      String refreshToken = jsonDecode(response1.body)["refresh_token"];
      assert(token != null && token.isNotEmpty);
      assert(refreshToken != null && refreshToken.isNotEmpty);
      savePref(token);
      Map<String, dynamic> body = new Map();
      body.putIfAbsent('fullName', () => fullName.trim());
      body.putIfAbsent('email', () => email.trim());
      body.putIfAbsent('phone', () => phone.trim());
      body.putIfAbsent('passwordHash', () => password.trim());
      savePhonePref(phone);
      apiHelper.initialize();
      http.Response response2 = await apiHelper.postWithoutAuth2(
          ApiEndpoint.register, jsonEncode(body));
      if (NetworkUtil.isReqSuccess(
        tag: "Add New User",
        response: response2,
      )) {
        final data = jsonDecode(response2.body);
        String message = data['operationStatus'];
        if (message == "SUCCESS") {
          send();
          setState(() {
            Navigator.pop(context);
            SnackbarUtils.show(_scaffoldKey, "Register Successful");
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (context) => new VerificationCodeScreen()));
          });
          print(message);
          registerToast(message);
        } else if (message == "ERROR") {
          print(message);
          registerToast(message);
        } else {
          print(message);
          registerToast(message);
        }
      } else {
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
      SnackbarUtils.show(_scaffoldKey, "Invalid Credentials. Please try again");
    }
  }

  send() async {
    Map<String, dynamic> payload = new Map();
    payload.putIfAbsent('username', () => "admin@default.com");
    payload.putIfAbsent('password', () => "admin");
    payload.putIfAbsent('grant_type', () => "password");

    http.Response response1 = await apiHelper.postWithoutAuth2(
        ApiEndpoint.getToken, jsonEncode(payload));
    if (NetworkUtil.isReqSuccess(
      tag: "access_token",
      response: response1,
    )) {
      String token = jsonDecode(response1.body)["access_token"];
      assert(token != null && token.isNotEmpty);
      savePref(token);
      apiHelper.initialize();

      Map<String, dynamic> body = new Map();
      body.putIfAbsent('number', () => phone.trim());
      http.Response response2 =
          await apiHelper.getWithoutAuth(ApiEndpoint.sendOtp + phone.trim());

      await apiHelper.getWithoutAuth(ApiEndpoint.sendOtp + phone.trim());

      if (NetworkUtil.isReqSuccess(
        tag: "send opt",
        response: response2,
      )) {
        final data = jsonDecode(response2.body);
        String message = data['operationStatus'];
        if (message == "SUCCESS") {
          setState(() {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => VerificationCodeScreen()));
            SnackbarUtils.show(_scaffoldKey, "Sent!");
          });
          print(message);
          registerToast(message);
        } else if (message == "ERROR") {
          print(message);
          registerToast(message);
        } else {
          print(message);
          registerToast(message);
        }
      } else {
        SnackbarUtils.show(_scaffoldKey, "Invalid Number. Please try again");
      }
    } else {
      SnackbarUtils.show(_scaffoldKey, "Invalid Number. Please try again");
    }
  }

  saveScreenPref(String screen) async {
    setState(() {
      prefsHelper.screen = screen;
    });
  }

  savePhonePref(String phone) async {
    setState(() {
      prefsHelper.phone = phone;
    });
  }

  savePref(String token) async {
    setState(() {
      prefsHelper.token = token;
    });
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
      msg: toast,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert Full Name";
                            }
                          },
                          onSaved: (e) => fullName = e,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.person,
                                    color: Colors.lightBlueAccent),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Fullname"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert Email";
                            }
                          },
                          onSaved: (e) => email = e,
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(
                                  Icons.email,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Email"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert Mobile Number";
                            }
                          },
                          onSaved: (e) => phone = e,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(
                                Icons.phone,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(18),
                            labelText: "Mobile",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        child: TextFormField(
                          obscureText: _secureText,
                          onSaved: (e) => password = e,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(_secureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(
                                  Icons.lock,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Password"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RaisedButton(
                            child: Text('Register'),
                            onPressed: () {
                              check();
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login(
                                screenHeight: null,
                              )));
                },
                child: RichText(
                  text: TextSpan(text: 'Have an account?', children: <TextSpan>[
                    TextSpan(
                      text: 'GoTo Login',
                    )
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
