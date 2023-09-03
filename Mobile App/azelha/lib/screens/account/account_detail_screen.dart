import 'package:azelha/data/bloc/user_bloc.dart';
import 'package:azelha/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Account();
}

class Account extends State<AccountDetailScreen> {
  String eid = '';
  final _userBloc = new UserBloc();
  String email = '';
  User _user;

  @override
  void initState() {
    super.initState();
    retrieveEmailFromPrefs();
    getPref();
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString("email");
      retrieveEmailFromPrefs();
    });
  }

  Future retrieveEmailFromPrefs() async {
    setState(() {
      _userBloc.initUserData(email);
      retrieveUserFromBackend();
    });
  }

  Future retrieveUserFromBackend() async {
    User user = await _userBloc.userController.first;
    setState(() {
      if (user != null) {
        _user = user;
      } else {
        _user = new User();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Icon ofericon = new Icon(
      Icons.edit,
      color: Colors.black38,
    );

    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          'My Account',
        ),
      ),
      body: new Container(
          child: SingleChildScrollView(
              child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(7.0),
            alignment: Alignment.topCenter,
            child: new Card(
              elevation: 3.0,
              child: Column(
                children: <Widget>[
                  new Container(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        margin: const EdgeInsets.all(10.0),
                        // padding: const EdgeInsets.all(3.0),
                        child: ClipOval(
                          child: Image.network(
                              'https://www.fakenamegenerator.com/images/sil-female.png'),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 10.0, top: 20.0, right: 5.0, bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text(
                              _user.email,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            _verticalDivider(),
                            new Text(
                              _user.phone ?? 'default value',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            ),
                            _verticalDivider(),
                            new Text(
                              _user.fullName ?? 'default value',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            icon: ofericon,
                            color: Colors.blueAccent,
                            onPressed: null),
                      )
                    ],
                  ),
                  // VerticalDivider(),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(7.0),
            child: GestureDetector(
              onTap: () {},
              child: Card(
                elevation: 1.0,
                child: Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.lock_outline), onPressed: null),
                    _verticalD(),
                    Text(
                      'Reset Password',
                      style: TextStyle(fontSize: 15.0, color: Colors.black87),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ))),
    );
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
