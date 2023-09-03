import 'package:azelha/contsants/colors.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

void _showDialogChangeLanguage(context, onPressed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Change language",
        ),
        content: Text(
            "Are you sure you want to change language, the app will restart?"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "No",
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
              child: Text(
                "Yes",
              ),
              onPressed: onPressed),
        ],
      );
    },
  );
}

String currentLanguage = 'English';
String languageSelected;
String radioButtonPicked = 'English';

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: RadioButtonGroup(
                  labels: ['English', 'French'],
                  labelStyle: TextStyle(
                      fontSize: kTextSecondary, fontWeight: FontWeight.w600),
                  picked: radioButtonPicked,
                  onSelected: (value) {
                    languageSelected = value;
                    if (currentLanguage != languageSelected) {
                      _showDialogChangeLanguage(context, () {});
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
