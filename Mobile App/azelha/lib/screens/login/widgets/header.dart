import 'package:azelha/contsants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'fade_slide_transition.dart';

class Header extends StatelessWidget {
  final Animation<double> animation;

  const Header({
    @required this.animation,
  }) : assert(animation != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: kSpaceM),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child: Text(
              'Welcome to Azelha',
            ),
          ),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child: Image.asset(
              "assets/OriginalTransparent.png",
              width: 320,
              height: 320,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
