import 'package:azelha/contsants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CardsStack extends StatelessWidget {
  final int pageNumber;
  final Widget lightCardChild;
  final Widget darkCardChild;
  final Animation<Offset> lightCardOffsetAnimation;
  final Animation<Offset> darkCardOffsetAnimation;

  const CardsStack({
    @required this.pageNumber,
    @required this.lightCardChild,
    @required this.darkCardChild,
    @required this.lightCardOffsetAnimation,
    @required this.darkCardOffsetAnimation,
  })  : assert(pageNumber != null),
        // assert(lightCardChild != null),
        assert(darkCardChild != null),
        //  assert(lightCardOffsetAnimation != null),
        assert(darkCardOffsetAnimation != null);

  bool get isOddPageNumber => pageNumber % 2 == 1;

  @override
  Widget build(BuildContext context) {
    var darkCardWidth = MediaQuery.of(context).size.width - 2 * kPaddingL;
    var darkCardHeight = MediaQuery.of(context).size.height / 3;

    return Padding(
      padding: EdgeInsets.only(
        top: isOddPageNumber ? 25.0 : 50.0,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        // ignore: deprecated_member_use
        overflow: Overflow.visible,
        children: <Widget>[
          SlideTransition(
            position: darkCardOffsetAnimation,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Container(
                width: darkCardWidth,
                height: darkCardHeight,
                padding: EdgeInsets.only(
                  top: !isOddPageNumber ? 100.0 : 0.0,
                  bottom: isOddPageNumber ? 100.0 : 0.0,
                ),
                child: Center(
                  child: darkCardChild,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
