import 'package:flutter/material.dart';

class ButtonPrincipal extends StatelessWidget {
  ButtonPrincipal({@required this.color, @required this.text, this.onPressed});

  final Color color;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(14.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      onPressed: onPressed,
      child: Text(text.toUpperCase()),
    );
  }
}

class ButtonSecondary extends StatelessWidget {
  ButtonSecondary({this.color, @required this.text, this.onPressed});

  final Color color;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(14.0),
      color: color,
      textColor: Colors.white,
      child: Text(
        text.toUpperCase(),
      ),
    );
  }
}
