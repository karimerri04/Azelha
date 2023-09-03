import 'package:azelha/contsants/colors.dart';
import 'package:azelha/contsants/dialog_utils.dart';
import 'package:azelha/contsants/shared_prefs_helper.dart';
import 'package:azelha/data/bloc/address_bloc.dart';
import 'package:azelha/data/bloc/customer.bloc.dart';
import 'package:azelha/data/bloc/database_helper.dart';
import 'package:azelha/data/bloc/eco_card_bloc.dart';
import 'package:azelha/data/bloc/product.bloc.dart';
import 'package:azelha/data/bloc/scan_bloc.dart';
import 'package:azelha/data/bloc/supplier_bloc.dart';
import 'package:azelha/data/bloc/user_bloc.dart';
import 'package:azelha/data/model/address_model.dart';
import 'package:azelha/data/model/article_model.dart';
import 'package:azelha/data/model/customer_model.dart';
import 'package:azelha/data/model/eco_card_model.dart';
import 'package:azelha/data/model/exchange_model.dart';
import 'package:azelha/data/model/product_model.dart';
import 'package:azelha/data/model/scan_db_model.dart';
import 'package:azelha/data/model/scan_model.dart';
import 'package:azelha/data/model/supplier_model.dart';
import 'package:azelha/data/model/tile_model.dart';
import 'package:azelha/data/model/user_model.dart';
import 'package:azelha/screens/account/eco_card_screen.dart';
import 'package:azelha/screens/home/home_screen.dart';
import 'package:azelha/screens/login/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double _totalAmount = 0.0;
  double subTotal = 0.0;
  double otherAmount = 0.0;
  double _tax = 4.99;
  double _fee = 3.99;
  String _email;
  int _orderCount;
  String _checkoutComments;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  ScrollController _controller = ScrollController();
  TextEditingController _commentController = new TextEditingController();
  User _user = new User();
  List<Customer> _customers;
  Customer _customer;
  Addresss _address = new Addresss();
  Exchange _exchange = new Exchange();
  Supplier _supplier = new Supplier();
  EcoCard _ecoCard = new EcoCard();
  EcoCard _myCard = new EcoCard();
  Scan _customerScanItem;
  int itemQun = 1;
  ScanItemDB _scanItemDB;
  final _userBloc = new UserBloc();
  final _addressBloc = new AddressBloc();
  final _ecoCardBloc = new EcoCardBloc();
  final _scanBloc = new ScanBloc();
  final _supplierBloc = new SupplierBloc();
  final _productBloc = new ProductBloc();
  final _customerBloc = new CustomerBloc();

  List<ScanItemDB> scanItemsList = <ScanItemDB>[];
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    retrieveUserFromBackend().then((data) {
      setState(() {
        this._user = data;
        retrieveAddressFromBackend().then((data) {
          setState(() {
            this._address = data;
            retrieveSupplierFromBackend().then((data) {
              setState(() {
                this._supplier = data;
                retrieveEcoCardFromBackend().then((data) {
                  setState(() {
                    this._ecoCard = data;
                    retrieveScanItemsFromDB().then((data) {
                      setState(() {
                        scanItemsList = data;
                        calculateTotal().then((data) {
                          setState(() {
                            _totalAmount = data;
                          });
                        });
                      });
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
  }

  Future getEmailPref() async {
    _email = prefsHelper.email;
    return _email;
  }

  int calcRanks(ranks) {
    double multiplier = .5;
    return (multiplier * ranks).round();
  }

  Future retrieveUserFromBackend() async {
    await _userBloc.initUserData('admin@default.com');
    _user = await _userBloc.userController.first;
    return _user;
  }

  Future retrieveAddressFromBackend() async {
    await _addressBloc.initAddressData(_user.id);
    _address = await _addressBloc.addressController.first;
    return _address;
  }

  Future retrieveEcoCardFromBackend() async {
    await _ecoCardBloc.getActiveEcoCardData(_user.id);
    _ecoCard = await _ecoCardBloc.creditCartController.first;
    return _ecoCard;
  }

  Future retrieveSupplierFromBackend() async {
    _supplier = await _supplierBloc.supplierController.first;
    return _supplier;
  }

  Future retrieveConsumerFromBackend() async {
    await _customerBloc.initCustomerData(_user.id);
    _customers = await _customerBloc.customersController.first;
    return _customers;
  }

  Future retrieveSubTotalFromPrefs() async {
    return (prefsHelper.subTotal ?? 0.0);
  }

  Future retrieveOtherAmountFromPrefs() async {
    otherAmount = double.parse(myController.text);
    return otherAmount;
  }

  Future retrieveScanItemsFromDB() async {
    var fetchedScanItems = await DatabaseHelper.db.getScanItemsFromDB();
    return fetchedScanItems;
  }

  Future deleteTable() async {
    await DatabaseHelper.db.delete();
    // await DatabaseHelper.db.deleteDB();
  }

  Future calculateTotal() async {
    for (final scanItemDB in scanItemsList) {
      _totalAmount = _totalAmount + scanItemDB.points;
    }
    return _totalAmount;
  }

  Future addCustomerScan() async {
    _myCard = new EcoCard(
      ecoCardNum: _ecoCard.ecoCardNum,
      expDate: _ecoCard.expDate,
    );
    _exchange = new Exchange(
      ecocard: _myCard.toMap(),
      point: _totalAmount,
    );
    List<Map<String, dynamic>> articles = <Map<String, dynamic>>[];

    for (final scanItemDB in scanItemsList) {
      await _productBloc.getProductByBarCode(scanItemDB.barcode_number);
      _ecoCard = await _ecoCardBloc.creditCartController.first;
      Product product = await _productBloc.productSubject.first;

      print('the product is' + product.barCode);

      articles.add(new Article(
        barcode_number: '0667888012916',
        barcode_type: scanItemDB.barcode_type,
        barcode_formats: scanItemDB.barcode_formats,
        mpn: scanItemDB.mpn,
        model: scanItemDB.model,
        asin: scanItemDB.asin,
        package_quantity: scanItemDB.package_quantity,
        size: scanItemDB.size,
        length: scanItemDB.length,
        width: scanItemDB.width,
        height: scanItemDB.height,
        weight: scanItemDB.weight,
        description: scanItemDB.description,
        image: scanItemDB.image,
        points: scanItemDB.points,
        status: scanItemDB.status,
        product: product.toMap(),
      ).toMap());

      if (articles.length == scanItemsList.length) {
        break;
      }
    }

    retrieveConsumerFromBackend().then((data) {
      setState(() {
        if (_customers != null) {
          _customers = data;
          _customer = _customers[0];
        } else {
          _customer = new Customer(user: _user.toMap());
        }

        _checkoutComments = _commentController.text;
        print("the _checkoutComments is" + this._checkoutComments);
        final DateTime now = DateTime.now();
        final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
        final String formattedDate = formatter.format(now);
        print('the articles is' + articles.length.toString());

        _customerScanItem = new Scan(
          articles: articles,
          customer: _customer.toMap(),
          scanDate: formattedDate,
          address: _address.toMap(),
          exchange: _exchange.toMap(),
          supplier: _supplier.toMap(),
          checkoutComment: _checkoutComments,
        );
        print('the scan is' + _customerScanItem.articles[0].toString());
        _scanBloc.addCustomerScan(_customerScanItem);
      });
    });
    print('the customer is' + _customers[0].toMap().toString());
  }

  @override
  Widget build(BuildContext context) {
    if (_user != null && _address != null && _ecoCard != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Checkout'),
        ),
        body: new SingleChildScrollView(
          child: Container(
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Scan address',
                                textAlign: TextAlign.start,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Divider(
                                  height: 1.0,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_on),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    _address.addressLine1 ?? 'default value',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.phone),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    _user.phone ?? 'default value',
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Divider(
                                  height: 1.0,
                                ),
                              ),
                              Text(
                                'Scan instructions (optional)',
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextFormField(
                                  controller: _commentController,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'Enter scan instructions',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    border: InputBorder.none,
                                  ),
                                  onSaved: (e) => _checkoutComments = e,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 108.0,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'EcoCard',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Divider(
                                  height: 1.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EcoCardScreen()));
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.credit_card,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      _ecoCard.ecoCardNum ?? 'default value',
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Summary',
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Divider(
                                  height: 1.0,
                                ),
                              ),
                              ListView.builder(
                                  controller: _controller,
                                  shrinkWrap: true,
                                  itemCount: scanItemsList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return new InkWell(
                                      child: FutureBuilder<double>(builder:
                                          (BuildContext context,
                                              AsyncSnapshot<double> snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            return const CircularProgressIndicator();
                                          default:
                                            if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    scanItemsList[index]
                                                            .model ??
                                                        'default value',
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    scanItemsList[index]
                                                            .points
                                                            .toString() ??
                                                        'default value',
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              ),
                                            );
                                        }
                                      }),
                                    );
                                  }),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Divider(
                                  height: 1.0,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Total',
                                    textAlign: TextAlign.start,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 15.0,
                                    ),
                                  ),
                                  Text(
                                    "${_totalAmount.toStringAsFixed(2)}\$" ??
                                        'default value',
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      color: primaryDarkColor,
                      textColor: primaryTextColor,
                      text: 'Confirm Scan',
                      onPressed: () {
                        addCustomerScan();
                        deleteTable();
                        Future.delayed(const Duration(milliseconds: 3000), () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        });
                      }),
                ]),
          ),
        ),
      );
    } else {
      return DialogUtils.showCircularProgressBar();
    }
  }
}

class TileItemsScreen extends StatelessWidget {
  final TileItem _item;

  TileItemsScreen(this._item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: <Widget>[
          Text(
            _item.description ?? 'default value',
            textAlign: TextAlign.start,
          ),
          Expanded(
            child: SizedBox(
              width: 15.0,
            ),
          ),
          Text(
            _item.amount ?? 'default value',
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
