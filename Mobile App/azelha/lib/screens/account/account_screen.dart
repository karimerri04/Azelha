import 'package:azelha/contsants/colors.dart';
import 'package:azelha/contsants/dialog_utils.dart';
import 'package:azelha/contsants/shared_prefs_helper.dart';
import 'package:azelha/data/bloc/address_bloc.dart';
import 'package:azelha/data/bloc/customer.bloc.dart';
import 'package:azelha/data/bloc/scan_bloc.dart';
import 'package:azelha/data/bloc/user_bloc.dart';
import 'package:azelha/data/model/address_model.dart';
import 'package:azelha/data/model/article_model.dart';
import 'package:azelha/data/model/customer_model.dart';
import 'package:azelha/data/model/scan_model.dart';
import 'package:azelha/data/model/user_model.dart';
import 'package:azelha/screens/account/setting_screen.dart';
import 'package:azelha/screens/exchange/exchange_screen.dart';
import 'package:azelha/screens/login/forgot_password_screen.dart';
import 'package:azelha/screens/login/login.dart';
import 'package:azelha/widgets/dialog_logout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

import 'account_detail_screen.dart';
import 'help_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Account();
}

class Account extends State<AccountScreen> with TickerProviderStateMixin {
  String eid = '';
  final _userBloc = new UserBloc();
  final _scanBloc = new ScanBloc();
  final _addressBloc = new AddressBloc();
  final _customerBloc = new CustomerBloc();
  String email = '';
  User _user;
  Addresss _addressItem;
  String companyValue;
  String categoryValue;
  String address;
  List<Customer> _customers = [];
  List<Article> _articles = [];
  List<Scan> _scanListSubject = [];

  double _totalPoint = 0.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    retrieveUserFromBackend().then(
      (data) => setState(() {
        this._user = data;
        retrieveAddressUserFromBackend().then((data) => setState(() {
              this._addressItem = data;
              retrieveListUserCostumersFromBackend().then(
                (data) => setState(() {
                  this._customers = data;
                  retrieveScanFromBackend().then((data) => setState(() {
                        this._scanListSubject = data;
                        print('the size scans is ' +
                            _scanListSubject.length.toString());
                        retrieveScanArticlesFromBackend()
                            .then((data) => setState(() {
                                  this._articles = data;

                                  calculateTotal().then((data) => setState(() {
                                        this._totalPoint = data;
                                      }));
                                }));
                      }));
                }),
              );
            }));
      }),
    );
  }

  Future calculateTotal() async {
    for (final article in _articles) {
      _totalPoint = _totalPoint + article.points;
    }
    return _totalPoint;
  }

  Future getPref() async {
    email = prefsHelper.email;
    return email;
  }

  Future retrieveAddressUserFromBackend() async {
    await _addressBloc.initAddressData(_user.id);
    _addressItem = await _addressBloc.addressController.first;
    return _addressItem;
  }

  Future retrieveListUserCostumersFromBackend() async {
    await _customerBloc.initCustomerData(_user.id);
    _customers = await _customerBloc.customersController.first;
    return _customers;
  }

  Future retrieveScanFromBackend() async {
    for (final customer in _customers) {
      await _scanBloc.getScansByCostumer(customer.id);
      _scanListSubject = await _scanBloc.scanListSubject.first;
      return _scanListSubject;
    }
  }

  Future retrieveScanArticlesFromBackend() async {
    for (final scan in _scanListSubject) {
      print('the size articles is ' +
          scan.id.toString() +
          _articles.length.toString());
      for (final article in scan.articles) {
        _articles.add(Article.fromMap(article));
      }
    }
    return _articles;
  }

  Future retrieveUserFromBackend() async {
    await _userBloc.initUserData('admin@default.com');
    _user = await _userBloc.userController.first;
    return _user;
  }

// To do: nbr articles / nbr points
  final List<List<double>> charts = [
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ]
  ];
  static final List<String> chartDropdownItems = [
    'Last 7 days',
    'Last month',
    'Last year'
  ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;
  @override
  Widget build(BuildContext context) {
    IconData _backIcon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_back;
        case TargetPlatform.iOS:
          return Icons.arrow_back_ios;
        case TargetPlatform.linux:
          // TODO: Handle this case.
          break;
        case TargetPlatform.macOS:
          // TODO: Handle this case.
          break;
        case TargetPlatform.windows:
          // TODO: Handle this case.
          break;
      }
      assert(false);
      return null;
    }

    Future logout() async {
      var screenHeight = MediaQuery.of(context).size.height;
      await _userBloc.logout(_user.id);
      prefsHelper.token = null;
      prefsHelper.email = null;
      prefsHelper.clear();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Login(
                screenHeight: screenHeight,
              )));
    }

    if (_user != null) {
      return new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(_backIcon()),
            alignment: Alignment.centerLeft,
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Account',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  //  margin: EdgeInsets.all(7.0),
                  child: _buildTile(
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AccountDetailScreen()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    (_user.fullName ?? 'default value'),
                                    style: TextStyle(color: primaryColor),
                                  ),
                                  Text(
                                    _user.email ?? 'default value',
                                  ),
                                  CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://www.fakenamegenerator.com/images/sil-male.png")),
                                ],
                              ),
                            )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Points',
                                ),
                                Text(
                                  '${_totalPoint.toStringAsFixed(2)}\&' ??
                                      'default value',
                                ),
                              ],
                            ),
                            DropdownButton(
                                isDense: true,
                                value: actualDropdown,
                                onChanged: (String value) => setState(() {
                                      actualDropdown = value;
                                      actualChart = chartDropdownItems
                                          .indexOf(value); // Refresh the chart
                                    }),
                                items: chartDropdownItems.map((String title) {
                                  return DropdownMenuItem(
                                      value: title,
                                      child: Text(
                                        title,
                                      ));
                                }).toList())
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 4.0)),
                        Sparkline(
                          data: charts[actualChart],
                          lineWidth: 5.0,
                          lineColor: Colors.greenAccent,
                        )
                      ],
                    )),
              )),

              //staggeredTiles: [
              //  StaggeredTile.extent(2, 110.0),
              //  StaggeredTile.extent(2, 288.0),
              //],

              Container(
                  margin: EdgeInsets.all(7.0),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text("Settings"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingScreen(
                                  toolbarname: 'Settings',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(7.0),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.credit_card),
                          title: Text("Exchange methods"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExchangeScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(7.0),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.help),
                          title: Text("Help"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HelpScreen(
                                  toolbarname: 'Help',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(7.0),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text(
                        "Logout",
                      ),
                      onTap: () {
                        DialogLogout().dialogLogout(context, () {
                          Navigator.pop(context);
                          logout();
                        });
                      },
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(7.0),
                child: Card(
                  elevation: 1.0,
                  child: ListTile(
                    leading: Icon(Icons.lock_outline),
                    title: Text(
                      'Reset Password',
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return DialogUtils.showCircularProgressBar();
    }
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
}
