import 'dart:convert';

import 'package:azelha/contsants/network_util.dart';
import 'package:azelha/contsants/shared_prefs_helper.dart';
import 'package:azelha/contsants/snackbar_utils.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:azelha/data/remote/api_helper.dart';
import 'package:azelha/widgets/button_circle.dart';
import 'package:azelha/widgets/button_principal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'create_new_password_screen.dart';
import 'login.dart';

class VerificationCodeScreen extends StatefulWidget {
  @override
  _VerificationCodeState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCodeScreen> {
  String key, phone, screen;
  final _key = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    ApiHelper().initialize();

    getPref().then((data) {
      setState(() {
        this.phone = data;
      });
    });

    getScreenPref().then((data) {
      setState(() {
        this.screen = data;
        print("the value of screen is " + screen);
      });
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      verify();
    }
  }

  verify() async {
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
      savePref(token, refreshToken);

      Map<String, dynamic> body = new Map();
      body.putIfAbsent('number', () => key.trim());

      apiHelper.initialize();

      http.Response response2 =
          await apiHelper.getWithoutAuth(ApiEndpoint.verifyOtp + key.trim());
      if (NetworkUtil.isReqSuccess(
        tag: "send opt",
        response: response2,
      )) {
        final data = jsonDecode(response2.body);
        String message = data['operationStatus'];
        if (message == "SUCCESS") {
          setState(() {
            if (screen == "password") {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateNewPasswordScreen()));
            } else if (screen == "register") {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login(
                            screenHeight: null,
                          )));
              SnackbarUtils.show(_scaffoldKey, "Valid!");
            }
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

  reSend() async {
    Map<String, dynamic> body = new Map();
    body.putIfAbsent('number', () => phone.trim());
    apiHelper.initialize();

    http.Response response =
        await apiHelper.getWithoutAuth(ApiEndpoint.sendOtp + phone.trim());
    if (NetworkUtil.isReqSuccess(
      tag: "send opt",
      response: response,
    )) {
      final data = jsonDecode(response.body);
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
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
      msg: toast,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  savePref(String token, String refreshToken) async {
    setState(() {
      prefsHelper.token = token;
      prefsHelper.refreshToken = refreshToken;
      prefsHelper.phone = phone;
    });
  }

  Future getPref() async {
    phone = prefsHelper.phone;
    return phone;
  }

  Future getScreenPref() async {
    screen = prefsHelper.screen;
    return screen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Verification code'),
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
                              Icons.lock,
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(height: 30.0),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Enter the verification code we just you to your mobile phone',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              maxLength: 6,
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Please insert digits code";
                                }
                              },
                              onSaved: (e) => key = e,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(Icons.confirmation_number,
                                      color: Colors.lightBlueAccent),
                                ),
                                contentPadding: EdgeInsets.all(18),
                                labelText: "6 Digits Code",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ButtonPrincipal(
                              onPressed: () {
                                check();
                              },
                              text: 'CONFIRM',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      reSend();
                    },
                    child: RichText(
                      text: TextSpan(
                          text: 'Didn\'t receive code?',
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Resend',
                            )
                          ]),
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
