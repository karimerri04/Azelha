import 'package:azelha/screens/login/login.dart';
//import 'package:azelha/screens/login/loginUi.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:splashscreen/splashscreen.dart';

import 'contsants/colors.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new AzelhaApp(),
  ));
}

class AzelhaApp extends StatefulWidget {
  AzelhaApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AzelhaAppState createState() => _AzelhaAppState();
}

class _AzelhaAppState extends State<AzelhaApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Azelha Demo', //title of app,
        //ThemeData
        home: SplashScreen(
          seconds: 3,
          navigateAfterSeconds: new AfterSplash(),
          image: Image.asset(
            'assets/OriginalTransparent.png',
          ),
          photoSize: 230.0,
        )); //IntroViewsFlutter//Builder
  }
}

class AfterSplash extends StatelessWidget {
  final pages = [
    PageViewModel(
      pageColor: primaryColor,
      body: Text(
        'We focus on disposing of all waste sustainably and minimizing environmental impact.',
      ),
      title: Text('AZELHA'),
      mainImage: Image.asset(
        'assets/CleanEnvironment.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      iconImageAssetPath: ('assets/catalogue3.png'),
      bubble: Image.asset('assets/catalogue3.png'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Azelha Demo', //title of app
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      //ThemeData
      home: Builder(builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;
        return IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(
                  screenHeight: screenHeight,
                ),
              ), //MaterialPageRoute
            );
          },
        );
      } //IntroViewsFlutter
          ), //Builder
    );
    return app;
  }
}
