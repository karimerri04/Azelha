import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput(
      {@required this.hintText,
      @required this.obscureText,
      @required this.colorBorder,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.onChanged,
      this.validator,
      this.maxLength,
      this.controller,
      this.autoFocus = false,
      this.onSaved});

  final String hintText;
  final bool obscureText;
  final Color colorBorder;
  final Function onChanged;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final Icon prefixIcon;
  final Function validator;
  final int maxLength;
  final Function onSaved;
  final bool autoFocus;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      autofocus: autoFocus,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textAlign: TextAlign.start,
      validator: validator,
      maxLength: maxLength,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        counterText: '',
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorBorder, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorBorder, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
