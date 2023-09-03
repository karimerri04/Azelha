import 'package:flutter/material.dart';

class ButtonCircle extends StatelessWidget {
  ButtonCircle({this.image, this.onPressed});

  final Widget image;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: image,
      shape: CircleBorder(),
      elevation: 3.0,
      fillColor: Colors.white,
      padding: EdgeInsets.all(15.0),
    );
  }
}
