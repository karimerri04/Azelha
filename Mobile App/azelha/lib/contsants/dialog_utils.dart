import 'package:flutter/material.dart';

import 'colors.dart';

class DialogUtils {
  static void showProgressBar(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new Dialog(
        child: new Container(
          height: 80.0,
          padding: const EdgeInsets.all(20.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  strokeWidth: 1.0,
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: new Text(
                  text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget showCircularProgressBar() {
    return new Center(
        child: new CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
      strokeWidth: 5.0,
    ));
  }
}
