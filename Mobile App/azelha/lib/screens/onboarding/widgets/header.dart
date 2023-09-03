import 'package:azelha/contsants/colors.dart';
import 'package:azelha/widgets/logo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final VoidCallback onSkip;

  const Header({
    @required this.onSkip,
  }) : assert(onSkip != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Logo(
          color: primaryColor,
          size: 32.0,
        ),
        GestureDetector(
          onTap: onSkip,
          child: Text(
            'Skip',
          ),
        ),
      ],
    );
  }
}
