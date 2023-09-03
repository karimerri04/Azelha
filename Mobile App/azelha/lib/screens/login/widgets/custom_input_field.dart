import 'package:azelha/contsants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final bool obscureText;

  const CustomInputField({
    @required this.label,
    @required this.prefixIcon,
    this.obscureText = false,
  })  : assert(label != null),
        assert(prefixIcon != null);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(kPaddingM),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.12),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.12),
          ),
        ),
        hintText: label,
        prefixIcon: Icon(
          prefixIcon,
        ),
      ),
      obscureText: obscureText,
    );
  }
}
