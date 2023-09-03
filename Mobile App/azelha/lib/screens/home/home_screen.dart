import 'package:azelha/animation/animation_dialog.dart';
import 'package:azelha/contsants/dialog_utils.dart';
import 'package:azelha/data/bloc/address_bloc.dart';
import 'package:azelha/data/bloc/customer.bloc.dart';
import 'package:azelha/data/bloc/database_helper.dart';
import 'package:azelha/data/bloc/eco_card_bloc.dart';
import 'package:azelha/data/bloc/product.bloc.dart';
import 'package:azelha/data/bloc/scan_bloc.dart';
import 'package:azelha/data/bloc/user_bloc.dart';
import 'package:azelha/data/model/address_model.dart';
import 'package:azelha/data/model/customer_model.dart';
import 'package:azelha/data/model/eco_card_model.dart';
import 'package:azelha/data/model/exchange_model.dart';
import 'package:azelha/data/model/product_model.dart';
import 'package:azelha/data/model/scan_db_model.dart';
import 'package:azelha/data/model/scan_model.dart';
import 'package:azelha/data/model/time_model.dart';
import 'package:azelha/data/model/user_model.dart';
import 'package:azelha/screens/account/account_screen.dart';
import 'package:azelha/screens/exchange/checkout_screen.dart';
import 'package:azelha/screens/tab/product_tab.dart';
import 'package:azelha/screens/tab/scan_tab.dart';
import 'package:azelha/widgets/bottom_bar.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/model/android_options.dart';
import 'package:barcode_scan/model/scan_options.dart';
import 'package:barcode_scan/model/scan_result.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _flashOnController = TextEditingController(text: "Flash on");
  final _flashOffController = TextEditingController(text: "Flash off");
  final _cancelController = TextEditingController(text: "Cancel");
  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  ScanResult scanResult;
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);
  var _aspectTolerance = 0.00;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;
  int _selectedPageIndex = 0;
  double _totalAmount = 0.0;

  final _userBloc = new UserBloc();
  User _user = new User();
  final _addressBloc = new AddressBloc();
  Addresss _address = new Addresss();
  final _productBloc = new ProductBloc();
  Product _product = new Product();
  final _ecoCardBloc = new EcoCardBloc();
  EcoCard _ecoCard = new EcoCard();
  final _scanBloc = new ScanBloc();
  final _customerBloc = new CustomerBloc();
  Exchange _exchange = new Exchange();
  Customer _customer;
  List<Customer> _customers;
  TimeItem _timeItem = new TimeItem();
  Scan _scan;
  // ignore: deprecated_member_use
  List<Map<String, dynamic>> articles = new List<Map<String, dynamic>>();
  List<ScanItemDB> _scanItemsDB;

  final List<IconData> _bottomBarItemIconList = [
    Icons.home,
    Icons.scanner,
    Icons.attach_money,
    Icons.account_box
  ];

  final List<String> _bottomBarItemList = [
    "Home",
    "Scan",
    "Exchange",
    "Account",
  ];

  final List<Widget> _pageList = [
    ProductTab(),
    ScanTab(),
    CheckoutScreen(),
    AccountScreen()
  ];

  void onBottomBarItemTap(String item) {
    setState(() {
      _selectedPageIndex = _bottomBarItemList.indexOf(item);
    });
  }

  Future retrieveProductFromBackend() async {
    await _productBloc.getProductById(1);
    _product = await _productBloc.productStream.first;
    return _product;
  }

  @override
  void initState() {
    super.initState();

    retrieveUserFromBackend().then(
      (data) => setState(() {
        this._user = data;
        retrieveAddressUserFromBackend().then((data) => setState(() {
              this._address = data;
              retrieveProductFromBackend().then((data) => setState(() {
                    this._product = data;
                  }));
            }));
      }),
    );
  }

  Future retrieveUserFromBackend() async {
    await _userBloc.initUserData("admin@default.com");
    User user = await _userBloc.userController.first;
    return user;
  }

  Future retrieveAddressUserFromBackend() async {
    await _addressBloc.initAddressData(_user.id);
    _address = await _addressBloc.addressController.first;
    return _address;
  }

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
        restrictFormat: selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);
      setState(() => {
            scanResult = result,
            saveScanToDataBaseItem(scanResult),
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AnimationDialog(
                      scanResult: scanResult,
                    )))
          });
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }

  Future<void> saveScanToDataBaseItem(ScanResult scanResult) async {
    setState(() {
      DatabaseHelper.db.saveScanItem(new ScanItemDB(
        barcode_number: scanResult.rawContent ?? "",
        barcode_type: scanResult.type?.toString() ?? "",
        barcode_formats: scanResult.format?.toString() ?? "",
        mpn: '',
        model: scanResult.rawContent ?? "",
        asin: '',
        package_quantity: '',
        size: '',
        length: '',
        width: '',
        height: '',
        weight: '',
        description: '',
        image: '',
        points: int.parse(scanResult.rawContent) ~/ 20000,
        status: 'NEW',
      ));
    });
  }

  Future retrieveConsumerFromBackend() async {
    await _customerBloc.initCustomerData(_user.id);
    _customers = await _customerBloc.customersController.first;
    return _customers;
  }

  @override
  Widget build(BuildContext context) {
    if (_user != null && _address != null) {
      return Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
            scan();
          }),
          backgroundColor: Colors.lightGreen,
          tooltip: 'Scan Code Bar',
          child: Icon(Icons.camera),
        ),
        body: _pageList.elementAt(_selectedPageIndex),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 45.0,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _bottomBarItemList
                  .map(
                    (item) => BottomBarItem(
                        item,
                        _selectedPageIndex == _bottomBarItemList.indexOf(item),
                        _bottomBarItemIconList.elementAt(
                          _bottomBarItemList.indexOf(item),
                        ),
                        onBottomBarItemTap),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    } else {
      return DialogUtils.showCircularProgressBar();
    }
  }
}
