import 'package:azelha/contsants/colors.dart';
import 'package:azelha/screens/scan/past_scan_screen.dart';
import 'package:azelha/screens/scan/up_coming_scan_screen.dart';
import 'package:azelha/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class ScanTab extends StatefulWidget {
  const ScanTab({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScanTabState();
  }
}

class _ScanTabState extends State<ScanTab> with TickerProviderStateMixin {
  TabController _tabController;
  List<Widget> tabBarViews;

  @override
  void initState() {
    super.initState();
    tabBarViews = <Widget>[UpComingScanScreen(), PastScanScreen()];
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TabBar getTabBar() {
    return TabBar(
      labelStyle: TextStyle(fontSize: kTextTitle, fontWeight: FontWeight.w700),
      labelColor: primaryTextColor,
      indicatorColor: secondaryLightColor,
      indicatorWeight: 2.0,
      tabs: <Tab>[
        Tab(
          text: 'Upcoming Scans',
        ),
        Tab(
          text: 'Past Scans',
        )
      ],
      controller: _tabController,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return TabBarView(
      children: tabs,
      controller: _tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: '',
        bottom: getTabBar(),
      ),
      body: getTabBarView(
        <Widget>[
          tabBarViews[0],
          tabBarViews[1],
        ],
      ),
    );
  }
}
