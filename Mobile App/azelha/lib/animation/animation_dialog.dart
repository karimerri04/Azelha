import 'dart:ui';

import 'package:azelha/contsants/colors.dart';
import 'package:barcode_scan/model/scan_result.dart';
import 'package:flutter/material.dart';

double cartAmount = 30.01;

var _autoEnableFlash = false;

class AnimationDialog extends StatefulWidget {
  final ScanResult scanResult;
  AnimationDialog({@required this.scanResult});
  @override
  State<StatefulWidget> createState() => _AnimationDialogState();
}

class _AnimationDialogState extends State<AnimationDialog>
    with TickerProviderStateMixin {
  Animation<double> animation1;
  Animation<double> animation2;
  Animation<double> animation3;
  Animation<double> animation4;
  Animation<double> animation5;

  AnimationController animationController;
  var grade = "A";
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    switch (grade) {
      case "A":
        {
          animation1 =
              Tween<double>(begin: 0, end: -180).animate(animationController)
                ..addListener(() {
                  setState(() {});
                });
          animationController.forward();
          animation2 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation3 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation4 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation5 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
        }
        break;

      case "B":
        {
          animation2 =
              Tween<double>(begin: 0, end: -200).animate(animationController)
                ..addListener(() {
                  setState(() {});
                });
          animationController.forward();
          animation1 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation3 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation4 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation5 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
        }
        break;

      case "C":
        {
          animation3 =
              Tween<double>(begin: 0, end: -200).animate(animationController)
                ..addListener(() {
                  setState(() {});
                });
          animationController.forward();
          animation2 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation1 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation4 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation5 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
        }
        break;

      case "D":
        {
          animation4 =
              Tween<double>(begin: 0, end: -200).animate(animationController)
                ..addListener(() {
                  setState(() {});
                });
          animationController.forward();
          animation2 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation3 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation1 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation5 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
        }
        break;

      case "E":
        {
          animation5 =
              Tween<double>(begin: 0, end: -200).animate(animationController)
                ..addListener(() {
                  setState(() {});
                });
          animationController.forward();
          animation2 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation3 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation4 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
          animation1 =
              Tween<double>(begin: 0, end: 0).animate(animationController);
        }
        break;

      default:
        {
          print("Invalid choice");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Arbre.jpg'), fit: BoxFit.cover)),
        ),
        Align(
          alignment: AlignmentDirectional(-1.2, -0.7),
          child: Container(
            height: 100,
            width: 140,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/P1.png'),
            )),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(-0.6, -0.7),
          child: Container(
            height: 100,
            width: 140,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/P2.png'),
            )),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(0, -0.7),
          child: Container(
            height: 100,
            width: 140,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/P3.png'),
            )),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(0.6, -0.7),
          child: Container(
            height: 100,
            width: 140,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/P4.png'),
            )),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(1.2, -0.7),
          child: Container(
            height: 100,
            width: 140,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/P5.png'),
            )),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(-1, 0.25),
          child: Transform.translate(
            offset: Offset(0, animation1.value),
            child: Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/F1.png'),
              )),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(-0.5, 0.25),
          child: Transform.translate(
            offset: Offset(0, animation2.value),
            child: Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/F2.png'),
              )),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(0, 0.25),
          child: Transform.translate(
            offset: Offset(0, animation3.value),
            child: Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/F3.png'),
              )),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(0.5, 0.25),
          child: Transform.translate(
            offset: Offset(0, animation4.value),
            child: Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/F4.png'),
              )),
            ),
          ),
        ),
        Align(
          child: Transform.translate(
            offset: Offset(0, animation5.value),
            child: Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/F5.png'),
              )),
            ),
          ),
        ),
        if (widget.scanResult != null)
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15.0),
              child: new Column(children: <Widget>[
                Container(
                    color: primaryLightColor,
                    alignment: AlignmentDirectional(1.0, 1.0),
                    constraints:
                        BoxConstraints.expand(width: 250.0, height: 280.0),
                    margin: new EdgeInsets.only(
                        left: 150.0, bottom: 10.0, top: 750.0),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text("Result Type"),
                            subtitle:
                                Text(widget.scanResult.type?.toString() ?? ""),
                          ),
                          ListTile(
                            title: Text("Raw Content"),
                            subtitle: Text(
                                widget.scanResult.rawContent?.toString() ?? ""),
                          ),
                          ListTile(
                            title: Text("Format"),
                            subtitle: Text(
                                widget.scanResult.format?.toString() ?? ""),
                          ),
                          CheckboxListTile(
                            title: Text("Emballage vide"),
                            value: _autoEnableFlash,
                            onChanged: (checked) {
                              _autoEnableFlash = checked;
                            },
                          ),
                        ],
                      ),
                    ))
              ]),
            ),
          ),
        Align(
            alignment: AlignmentDirectional.bottomStart,
            child: FlatButton(
              color: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRadiusButton),
              ),
              child: Text(
                'CLOSE',
                style: TextStyle(color: secondaryTextColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: FlatButton(
            color: secondaryColor,
            textColor: secondaryTextColor,
            child: const Text('REPLAY', style: TextStyle(fontSize: 20)),
            onPressed: () {
              animationController.forward();
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
