import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  final String toolbarname;

  HelpScreen({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Help(toolbarname);
}

class Help extends State<HelpScreen> {
  List list = ['12', '11'];

  bool switchValue = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  Help(this.toolbarname);

  _launchUrl(String link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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

    final Orientation orientation = MediaQuery.of(context).orientation;
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
          'Help',
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Card(
                child: Container(
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
                              Icon(Icons.mail),
                              Container(
                                margin: EdgeInsets.only(left: 5.0),
                              ),
                              Text(
                                'Contact us',
                              ),
                            ],
                          ),
                          onTap: () {
                            _launchUrl('https://www.aladinapp.com/contact-us');
                          },
                        ),
                      ),
                      Divider(
                        height: 5.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10.0, top: 15.0, bottom: 15.0),
                        child: GestureDetector(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.help),
                                Container(
                                  margin: EdgeInsets.only(left: 5.0),
                                ),
                                Text(
                                  'FAQ',
                                ),
                              ],
                            ),
                            onTap: () {
                              _launchUrl(
                                  'https://www.aladinapp.com/faq-customer');
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
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

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  Widget _status(status) {
    if (status == 'Cancel Scan') {
      return FlatButton.icon(
          label: Text(
            status,
          ),
          icon: const Icon(
            Icons.highlight_off,
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
            size: 18.0,
          ),
          onPressed: () {
            // Perform some action
          });
    }
  }

  erticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Press to show";
      } else {
        a = true;
        mText = "Press to hide";
      }
    });
  }
}
