import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final Color color;
  final double size;

  const Logo({
    @required this.color,
    @required this.size,
  })  : assert(color != null),
        assert(size != null);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 4,
      child: new IconButton(
          icon: new Image.asset('assets/OriginalTransparent.png'),
          tooltip: 'Closes application',
          onPressed: () => null),

      /*     Icon(
        Icons.ac_unit_sharp,
        color: color,
        size: size,
      ),*/
    );
  }
}
