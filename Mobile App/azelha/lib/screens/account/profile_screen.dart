
import 'package:azelha/data/bloc/user_bloc.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen();

  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = new UserBloc();
  }

  String name = 'My Wishlist';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Profile",
          style: TextStyle(color: Colors.blueGrey[700]),
        ),
        iconTheme: IconThemeData(
          color: Colors.blueGrey[700],
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[

          new Card(
            child: UserAccountsDrawerHeader(
              accountName: new Text("Naomi A. Schultz"),
              accountEmail: new Text("NaomiASchultz@armyspy.com"),
              onDetailsPressed: () {
              },
              decoration: new BoxDecoration(
                backgroundBlendMode: BlendMode.difference,
                color: Colors.white30,
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://www.fakenamegenerator.com/images/sil-female.png")),
            ),
          ),
          new Card(
            elevation: 4.0,
            child: new Column(
              children: <Widget>[
                new ListTile(
                    leading: Icon(Icons.favorite),
                    title: new Text(name),
                    onTap: () {
                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: name,)));
                    }),
                new Divider(),
                new ListTile(
                    leading: Icon(Icons.history),
                    title: new Text("Order History "),
                    onTap: () {
                      //    Navigator.push(context, MaterialPageRoute(builder: (context)=> Oder_History(toolbarname: ' Order History',)));
                    }),
              ],
            ),
          ),
          new Card(
            elevation: 4.0,
            child: new Column(
              children: <Widget>[
                new ListTile(
                    leading: Icon(Icons.settings),
                    title: new Text("Setting"),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Setting_Screen(toolbarname: 'Setting',)));
                    }),
                new Divider(),
                new ListTile(
                    leading: Icon(Icons.help),
                    title: new Text("Help"),
                    onTap: () {
                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=> Help_Screen(toolbarname: 'Help',)));
                    }),
              ],
            ),
          ),
          new Card(
            elevation: 4.0,
            child: new ListTile(
                leading: Icon(Icons.power_settings_new),
                title: new Text(
                  "Logout",
                  style: new TextStyle(color: Colors.redAccent, fontSize: 17.0),
                ),
                onTap: () {
                  //  Navigator.push(context,MaterialPageRoute(builder: (context) => Login_Screen()));
                }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class MenuItem extends StatelessWidget {
  final String title;

  MenuItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.grey[100]),
              bottom: BorderSide(color: Colors.grey[100]))),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}

class WalletMenuItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.grey[100]),
              bottom: BorderSide(color: Colors.grey[100]))),
      child: ListTile(
        title: Text("DOT Wallet"),
        trailing: Container(
          height: 24.0,
          child: Text(
            "₹ 0",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
          decoration: BoxDecoration(
              color: Color(0xff64DD17),
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
    );
  }
}
