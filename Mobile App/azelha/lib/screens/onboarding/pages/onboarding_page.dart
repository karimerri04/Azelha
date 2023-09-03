import 'package:azelha/contsants/colors.dart';
import 'package:azelha/screens/onboarding/widgets/cards_stack.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final int number;
  final Widget darkCardChild;
  final Animation<Offset> darkCardOffsetAnimation;
  final Widget textColumn;

  const OnboardingPage({
    @required this.number,
    @required this.darkCardChild,
    @required this.darkCardOffsetAnimation,
    @required this.textColumn,
  })  : assert(number != null),
        assert(darkCardChild != null),
        assert(darkCardOffsetAnimation != null),
        assert(textColumn != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CardsStack(
          pageNumber: number,
          darkCardChild: darkCardChild,
          darkCardOffsetAnimation: darkCardOffsetAnimation,
        ),
        SizedBox(
          height: number % 2 == 1 ? 50.0 : 25.0,
        ),
        AnimatedSwitcher(
          duration: kCardAnimationDuration,
          child: textColumn,
        ),
      ],
    );
  }
}
