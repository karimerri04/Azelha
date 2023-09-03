import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  TopBar({this.title, this.bottom, this.leading, this.onTap});

  final String title;
  final Widget bottom;

  final Widget leading;
  final Function onTap;

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          child: Text(title),
          onTap: onTap,
        ),
        bottom: bottom,
        leading: leading,
      ),
    ]);
  }
}
