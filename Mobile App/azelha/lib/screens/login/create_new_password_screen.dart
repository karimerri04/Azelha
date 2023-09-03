import 'dart:convert';

import 'package:azelha/contsants/colors.dart';
import 'package:azelha/contsants/network_util.dart';
import 'package:azelha/contsants/shared_prefs_helper.dart';
import 'package:azelha/contsants/snackbar_utils.dart';
import 'package:azelha/data/remote/api_endpoint.dart';
import 'package:azelha/widgets/button_circle.dart';
import 'package:azelha/widgets/button_principal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'file:///C:/Users/Amazigh/AndroidWorkSpace/azelha/lib/data/remote/api_helper.dart';

import 'login.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPasswordScreen> {
  String newPassword;
  String phone;
  final _key = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  void initState() {
    super.initState();
    ApiHelper().initialize();

    getPref().then((data) {
      setState(() {
        this.phone = data;
      });
    });
  }

  Future getPref() async {
    setState(() {
      phone = prefsHelper.phone;
    });
    return phone;
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      send();
    }
  }

  send() async {
    Map<String, dynamic> params = new Map();
    params.putIfAbsent('number', () => int.parse(phone.trim()));
    params.putIfAbsent('newPassword', () => newPassword.trim());
    print("the retrive phone is" + phone.toString());
    apiHelper.initialize();
    http.Response response = await apiHelper.putWithoutAuth(
        ApiEndpoint.restPassword + phone.trim() + '/' + newPassword.trim(),
        jsonEncode(params));
    if (NetworkUtil.isReqSuccess(
      tag: "send new password",
      response: response,
    )) {
      final data = jsonDecode(response.body);
      String message = data['operationStatus'];
      if (message == "SUCCESS") {
        setState(() {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Login(
                        screenHeight: null,
                      )));
          SnackbarUtils.show(_scaffoldKey, "Rested!");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Create New Password'),
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
                    elevation: kElevation,
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 30.0),
                          ButtonCircle(
                            image: Icon(
                              Icons.lock_open,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.0),
                            child: TextFormField(
                              controller: _pass,
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Please insert Mobile Number";
                                }
                                return null;
                              },
                              onSaved: (e) => newPassword = e,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(
                                    Icons.phone,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(18),
                                labelText: "Enter new password",
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.0),
                            child: TextFormField(
                              controller: _confirmPass,
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Please insert Mobile Number";
                                }
                                if (e != _pass.text) return 'Not Match';
                                return null;
                              },
                              onSaved: (e) => newPassword = e,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(Icons.lock,
                                      color: Colors.lightBlueAccent),
                                ),
                                contentPadding: EdgeInsets.all(18),
                                labelText: "Confirm New Password",
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                          ),
                          SizedBox(height: 5.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
