import 'package:azelha/contsants/colors.dart';
import 'package:flutter/material.dart';

class TextColumn extends StatelessWidget {
  final String title;
  final String text;

  const TextColumn({
    @required this.title,
    @required this.text,
  })  : assert(title != null),
        assert(text != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: kSpaceS),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
