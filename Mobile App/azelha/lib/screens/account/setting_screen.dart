import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'language_screen.dart';

class SettingScreen extends StatefulWidget {
  final String toolbarname;
  Function(Brightness brightness) changeTheme;

  SettingScreen(
      {Key key, Function(Brightness brightness) changeTheme, this.toolbarname})
      : super(key: key) {
    this.changeTheme = changeTheme;
  }

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingScreen> {
  List list = ['12', '11'];
  String selectedTheme;
  bool switchValue = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    setState(() {
      if (Theme.of(context).brightness == Brightness.dark) {
        selectedTheme = 'dark';
      } else {
        selectedTheme = 'light';
      }
    });

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

    _launchURL(String destination) async {
      String url = destination;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

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
            'Settings',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50.0,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 7.0),
                child: Row(
                  children: <Widget>[
                    _verticalD(),
                    Text(
                      'Notification',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Card(
                    child: Container(
                  padding: EdgeInsets.only(
                      left: 10.0, top: 5.0, bottom: 5.0, right: 5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.notifications, color: Colors.black54),
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                          ),
                          Text(
                            'Notification',
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                          value: switchValue,
                          onChanged: (bool value) {
                            setState(() {
                              switchValue = value;
                            });
                          }),
                    ],
                  ),
                )),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
              ),
              Container(
                height: 50.0,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 7.0),
                child: Row(
                  children: <Widget>[
                    _verticalD(),
                    Text(
                      'Language',
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Card(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                            left: 10.0, top: 15.0, bottom: 15.0),
                        child: GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.language),
                              Container(
                                margin: EdgeInsets.only(left: 5.0),
                              ),
                              Text(
                                'English',
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LanguageScreen()));
                          },
                        )),
                  ],
                )),
              ),
              Container(
                height: 50.0,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 7.0),
                child: Row(
                  children: <Widget>[
                    _verticalD(),
                    Text(
                      'Legal',
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Card(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                            left: 10.0, top: 15.0, bottom: 15.0),
                        child: GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.assignment, color: Colors.black54),
                              Container(
                                margin: EdgeInsets.only(left: 5.0),
                              ),
                              Text(
                                'Terms Off Use',
                              ),
                            ],
                          ),
                          onTap: () {
                            _launchURL('https://www.aladinapp.com/privacy');
                          },
                        )),
                    Divider(
                      height: 5.0,
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
                      child: GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.gavel, color: Colors.black54),
                              Container(
                                margin: EdgeInsets.only(left: 5.0),
                              ),
                              Text('Privacy Policy'),
                            ],
                          ),
                          onTap: () {
                            _launchURL(
                                'https://www.aladinapp.com/terms-of-use');
                          }),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ));
  }

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        /*_scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('You selected: $value')
        ));*/
      }
    });
  }

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  Widget _status(status) {
    if (status == 'Cancel Scan') {
      return FlatButton.icon(
          label: Text(
            status,
          ),
          icon: const Icon(
            Icons.highlight_off,
            size: 18.0,
          ),
          onPressed: () {
            // Perform some action
          });
    } else {
      return FlatButton.icon(
          label: Text(
            status,
          ),
          icon: const Icon(
            Icons.check_circle,
          ),
          onPressed: () {
            // Perform some action
          });
    }
  }

  Widget buildCardWidget(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(offset: Offset(0, 8), blurRadius: 16)]),
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(16),
      child: child,
    );
  }

  Widget buildHeaderWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 16, left: 8),
      child: Text(
        'Settings',
      ),
    );
  }
}
