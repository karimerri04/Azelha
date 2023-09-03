import 'package:azelha/contsants/colors.dart';
import 'package:flutter/material.dart';

class DialogLogout {
  void dialogLogout(context, onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadiusCard),
          ),
          title: Text(
            "Logout",
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(child: Text("Yes"), onPressed: onPressed),
          ],
        );
      },
    );
  }
}
