import 'package:azelha/contsants/colors.dart';
import 'package:flutter/material.dart';

typedef void OnItemClick(String item);

class BottomBarItem extends StatelessWidget {
  final String text;

  final bool selected;

  final IconData rss_feed;

  final OnItemClick onBottomBarItemTap;
  List list = ['12', '11'];
  BottomBarItem(
      this.text, this.selected, this.rss_feed, this.onBottomBarItemTap);

  @override
  Widget build(BuildContext context) {
    if (rss_feed == Icons.shopping_cart) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            onBottomBarItemTap(text);
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  rss_feed,
                  size: 20.0,
                  color: selected ? primaryColor : secondaryColor,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            onBottomBarItemTap(text);
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  rss_feed,
                  size: 20.0,
                  color: selected ? primaryColor : secondaryColor,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
