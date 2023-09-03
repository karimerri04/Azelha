import 'package:azelha/contsants/colors.dart';
import 'package:azelha/contsants/dialog_utils.dart';
import 'package:azelha/data/bloc/address_bloc.dart';
import 'package:azelha/data/bloc/customer_scan_bloc.dart';
import 'package:azelha/data/bloc/user_bloc.dart';
import 'package:azelha/data/model/address_model.dart';
import 'package:azelha/data/model/scan_model.dart';
import 'package:azelha/data/model/user_model.dart';
import 'package:azelha/screens/exchange/scan_details.dart';
import 'package:flutter/material.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class UpComingScanScreen extends StatefulWidget {
  @override
  _UpComingScanScreenState createState() => _UpComingScanScreenState();
}

class _UpComingScanScreenState extends State<UpComingScanScreen> {
  User _user;
  Addresss _address;
  final _userBloc = new UserBloc();
  final _addressBloc = new AddressBloc();
  final _customerScanBloc = new CustomerScanBloc();
  List<Scan> itemList = [];

  @override
  void initState() {
    super.initState();

    retrieveUserFromBackend().then((data) {
      setState(() {
        this._user = data;
        retrieveAddressFromBackend().then((data) {
          setState(() {
            this._address = data;
            retrievePastScanByStatusFromBackend();
          });
        });
      });
    });
  }

  Future retrieveUserFromBackend() async {
    await _userBloc.initUserData("admin@default.com");
    _user = await _userBloc.userController.first;
    return _user;
  }

  Future<List<Scan>> retrievePastScanByStatusFromBackend() async {
    _customerScanBloc.initUpComScanByStatusData(
        _address.id, "NEW", "IN_PROCESS");
    itemList = await _customerScanBloc.upComingScanController.first;
    return itemList;
  }

  Future retrieveAddressFromBackend() async {
    await _addressBloc.initAddressData(_user.id);
    _address = await _addressBloc.addressController.first;
    return _address;
  }

  @override
  Widget build(BuildContext context) {
    if (_user != null && _address != null && itemList.length > 0) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              body: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 800.0,
                    ),
                    child: ListView.builder(
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            height: 220,
                            width: double.maxFinite,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ScanDetails(
                                          item: itemList[index],
                                        )));
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 2.0, color: primaryDarkColor),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(7),
                                    child: Stack(children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Stack(
                                          children: <Widget>[
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 5),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        scanIcon(
                                                            itemList[index]),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        scanNameSymbol(
                                                            itemList[index]),
                                                        Spacer(),
                                                        scanChange(
                                                            itemList[index]),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        changeIcon(
                                                            itemList[index]),
                                                        SizedBox(
                                                          width: 20,
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        scanAmount(
                                                            itemList[index])
                                                      ],
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          )));
    } else {
      return DialogUtils.showCircularProgressBar();
    }
  }

  Widget scanIcon(Scan data) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
            height: 60, width: 70, child: Image.asset("assets/27100763.jpg")),
      ),
    );
  }

  Widget scanNameSymbol(Scan data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: '${data.status}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: '\n${data.scanDate}',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget scanChange(Scan data) {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text: '${data.id}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: '\n${data.articles.length}',
                style: TextStyle(
                    color: secondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget changeIcon(Scan data) {
    return Align(
        alignment: Alignment.topRight,
        child: data.scanDate != null
            ? Icon(
                Typicons.arrow_sorted_down,
                color: primaryColor,
                size: 30,
              )
            : Icon(
                Typicons.arrow_sorted_up,
                color: primaryColor,
                size: 30,
              ));
  }

  Widget scanAmount(Scan data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: '\n${data.scanNumber}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '\n0.1349',
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
