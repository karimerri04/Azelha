import 'dart:convert';

import 'package:azelha/contsants/colors.dart';
import 'package:azelha/contsants/network_util.dart';
import 'package:azelha/contsants/shared_prefs_helper.dart';
import 'package:azelha/contsants/snackbar_utils.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:azelha/widgets/button_circle.dart';
import 'package:azelha/widgets/button_principal.dart';
import 'package:azelha/widgets/input_principal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'verification_code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  String phone;
  final _key = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    saveScreenPref('password');
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      send();
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
      savePhonePref(phone);
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

  registerToast(String toast) {
    return Fluttertoast.showToast(
      msg: toast,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  savePref(String token) async {
    setState(() {
      prefsHelper.token = token;
    });
  }

  savePhonePref(String phone) async {
    setState(() {
      prefsHelper.phone = phone;
    });
  }

  saveScreenPref(String screen) async {
    setState(() {
      prefsHelper.screen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Forgot password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 30.0),
                          ButtonCircle(
                            image: Icon(
                              Icons.phone_forwarded,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Enter the phone number associated with you account',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              child: Text(
                                'We will send you a code to reset your password',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.0),
                            child: TextInput(
                              hintText: 'Phone number',
                              autoFocus: true,
                              keyboardType: TextInputType.phone,
                              obscureText: false,
                              prefixIcon: Icon(
                                Icons.phone,
                              ),
                              colorBorder: primaryColor,
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Phone number can't be empty";
                                }
                                return null;
                              },
                              onChanged: (e) => phone = e,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ButtonPrincipal(
                              text: "SEND",
                              onPressed: () {
                                check();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
