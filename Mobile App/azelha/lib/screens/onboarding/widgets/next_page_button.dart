import 'package:azelha/contsants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NextPageButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextPageButton({
    @required this.onPressed,
  }) : assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: const EdgeInsets.all(kPaddingM),
      elevation: 0.0,
      shape: CircleBorder(),
      child: Icon(
        Icons.arrow_forward,
      ),
      onPressed: onPressed,
    );
  }
}
