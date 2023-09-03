import 'package:azelha/contsants/dialog_utils.dart';
import 'package:azelha/data/bloc/eco_card_bloc.dart';
import 'package:azelha/data/bloc/user_bloc.dart';
import 'package:azelha/data/model/eco_card_model.dart';
import 'package:azelha/data/model/user_model.dart';
import 'package:azelha/screens/account/eco_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExchangeScreen extends StatefulWidget {
  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  final _userBloc = new UserBloc();
  final _creditCardBloc = new EcoCardBloc();

  User _user;
  EcoCard _creditCard;
  String email = "admin@default.com";

  @override
  void initState() {
    super.initState();

    retrieveUserFromBackend().then((data) {
      setState(() {
        this._user = data;
        _creditCardBloc.getAllCard(_user.id);
      });
    });
  }

/*  Future getPref() async {
    email = prefsHelper.email;
    return email;
  }*/

  Future retrieveUserFromBackend() async {
    await _userBloc.initUserData("admin@default.com");
    _user = await _userBloc.userController.first;
    return _user;
  }

  Future retrieveItemsFromDB() async {
    await _userBloc.initUserData("admin@default.com");
    _user = await _userBloc.userController.first;
    return _user;
  }

  void setCardItems(EcoCard cardItem) {
    this._creditCard = cardItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment methods'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EcoCardScreen()));
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 10.0),
              StreamBuilder(
                stream: _creditCardBloc.creditCartControllerList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<EcoCard>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      primary: false,
                      padding: const EdgeInsets.all(10.0),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            children: <Widget>[
                              PaymentMethodListTile(
                                cardNumberLastFourDigits:
                                    snapshot.data[index].ecoCardNum,
                                creditCardType:
                                    snapshot.data[index].ecoCardType,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      snapshot.data[index].isActive = value;
                                      setCardItems(snapshot.data[index]);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return Center(
                      child: Text(
                        "Some error occured...",
                      ),
                    );
                  }
//                  else if (snapshot.data.length == 0) {
//                    return Center(
//                      child: Column(
//                        children: <Widget>[
//                          Text("You currently don't have payment methods")
//                        ],
//                      ),
//                    );
//                  }
                  else {
                    return DialogUtils.showCircularProgressBar();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodListTile extends StatelessWidget {
  PaymentMethodListTile(
      {@required this.cardNumberLastFourDigits,
      @required this.creditCardType,
      this.onChanged});

  final String cardNumberLastFourDigits;
  final String creditCardType;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        child: Material(
          elevation: creditCardType == creditCardType ? 3.0 : 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: RadioListTile(
              title: Text(
                '**** **** **** $cardNumberLastFourDigits',
                textAlign: TextAlign.end,
              ),
              groupValue: creditCardType,
              value: creditCardType,
              onChanged: onChanged),
        ),
      ),
    );
  }
}
