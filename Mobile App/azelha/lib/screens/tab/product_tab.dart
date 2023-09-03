import 'package:azelha/animation/animated_text.dart';
import 'package:azelha/contsants/dialog_utils.dart';
import 'package:azelha/data/bloc/address_bloc.dart';
import 'package:azelha/data/bloc/category_bloc.dart';
import 'package:azelha/data/bloc/customer.bloc.dart';
import 'package:azelha/data/bloc/product.bloc.dart';
import 'package:azelha/data/bloc/scan_bloc.dart';
import 'package:azelha/data/bloc/user_bloc.dart';
import 'package:azelha/data/model/address_model.dart';
import 'package:azelha/data/model/article_model.dart';
import 'package:azelha/data/model/customer_model.dart';
import 'package:azelha/data/model/product_model.dart';
import 'package:azelha/data/model/scan_model.dart';
import 'package:azelha/data/model/user_model.dart';
import 'package:azelha/screens/product/favorite_screen.dart';
import 'package:azelha/screens/product/product_details.dart';
import 'package:azelha/widgets/map_view.dart';
import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart' as wheel;
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loadinglistview/loading_gridview.dart';
import 'package:loadinglistview/widgets/grid_loading_style.dart';
import 'package:loadinglistview/widgets/listtile_loading_style.dart';

class ProductTab extends StatefulWidget {
  @override
  ProductTabState createState() {
    return new ProductTabState();
  }
}

class ProductTabState extends State<ProductTab> with TickerProviderStateMixin {
  wheel.FixedExtentScrollController _controller;
  bool headerShouldHide = false;
  final _categoryBloc = new CategoryBloc();
  final _productBloc = new ProductBloc();
  final _userBloc = new UserBloc();
  final _scanBloc = new ScanBloc();
  final _addressBloc = new AddressBloc();
  final _customerBloc = new CustomerBloc();
  ProductBloc _blocSearch = new ProductBloc();
  User _user;
  Addresss _addressItem;
  String companyValue;
  String categoryValue;
  String email;
  List<Customer> _customers = [];
  List<Article> _articles = [];
  List<Scan> _scanListSubject = [];
  double _totalPoint = 0.0;
  List<Product> itemList = [];

  final SearchBarController<Product> _searchBarController =
      SearchBarController();
  Icon _searchIcon = Icon(
    Icons.search,
  );
  bool isSearchClicked = false;
  final TextEditingController _filter = new TextEditingController();
  bool isReplay = false;

  Widget singlePersonWidget(Product product) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: AssetImage(product.defaultImage),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetails(
                          item: product,
                        )));
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            product.name,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '\$${product.listPrice.toStringAsFixed(2)}',
          )
        ],
      ),
    );
  }

  Future calculateTotal() async {
    for (final article in _articles) {
      _totalPoint = _totalPoint + article.points;
    }
    return _totalPoint;
  }

  Future retrieveListUserCostumersFromBackend() async {
    await _customerBloc.initCustomerData(1);
    _customers = await _customerBloc.customersController.first;
    return _customers;
  }

  Future retrieveScanFromBackend() async {
    for (final customer in _customers) {
      await _scanBloc.getScansByCostumer(customer.id);
      _scanListSubject = await _scanBloc.scanListSubject.first;
      return _scanListSubject;
    }
  }

  Future retrieveScanArticlesFromBackend() async {
    for (final scan in _scanListSubject) {
      for (final article in scan.articles) {
        _articles.add(Article.fromMap(article));
      }
    }
    return _articles;
  }

  Future retrieveCategoriesFromBackend() async {
    setState(() {
      _categoryBloc.initCategoryData();
    });
  }

  Future retrieveAddressUserFromBackend() async {
    await _addressBloc.initAddressData(1);
    _addressItem = await _addressBloc.addressController.first;
    return _addressItem;
  }

  Future retrieveUserFromBackend() async {
    await _userBloc.initUserData("admin@default.com");
    _user = await _userBloc.userController.first;
    return _user;
  }

  Future<List<Product>> retrieveProductsFromBackend() async {
    //await Future.delayed(const Duration(seconds: 3));
    await _productBloc.getAllData();
    itemList = await _productBloc.productListSubject.first;
    return itemList;
  }

  @override
  void initState() {
    super.initState();
    _examples = animatedTextExamples(onTap: () {});
    _controller = wheel.FixedExtentScrollController();
    retrieveProductsFromBackend().then((data) => setState(() {
          this.itemList = data;
        }));
    retrieveUserFromBackend().then(
      (data) => setState(() {
        this._user = data;
        retrieveAddressUserFromBackend().then((data) => setState(() {
              this._addressItem = data;
              retrieveListUserCostumersFromBackend().then(
                (data) => setState(() {
                  this._customers = data;
                  retrieveScanFromBackend().then((data) => setState(() {
                        this._scanListSubject = data;
                        retrieveScanArticlesFromBackend()
                            .then((data) => setState(() {
                                  this._articles = data;
                                  calculateTotal().then((data) => setState(() {
                                        this._totalPoint = data;
                                      }));
                                }));
                      }));
                }),
              );
            }));
      }),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(
          Icons.close,
        );
        isSearchClicked = true;
      } else {
        this._searchIcon = Icon(
          Icons.search,
        );
        isSearchClicked = false;
        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user != null &&
        _addressItem != null &&
        _productBloc.productListStream != null &&
        _categoryBloc.categoryController != null &&
        _productBloc.productListSubject != null) {
      return Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[createSilverAppBar()];
        },
        body: LoadingGridView(
          futureData: retrieveProductsFromBackend(),
          contentWidget: singlePersonWidget,
          loadingWidget: GridLoadingStyle(
            headerShape: BoxShape.rectangle,
            hasLeading: false,
            subtitleAlignment: CrossAxisAlignment.center,
          ),
        ),
      ));
    } else {
      return DialogUtils.showCircularProgressBar();
    }
  }

// ignore: missing_return
  Future<List<Product>> _getItemsByName(String _searchTerm) async {
    itemList.forEach((value) {
      // ignore: unrelated_type_equality_checks
      if (value == _searchTerm) print('the value is ' + value.name);
      return value;
    });
  }

  List<AnimatedTextExample> _examples;
  int _index = 0;

  Widget loadingWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTileLoadingStyle(
        leadingShape: BoxShape.rectangle,
        leadingSize: 70,
        titleWidth: 150,
        subtitleWidth: 120,
        titleBorderRadius: 0,
        subtitleBorderRadius: 0,
      ),
    );
  }

  SliverAppBar createSilverAppBar() {
    final animatedTextExample = _examples[_index];
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      floating: false,
      elevation: 2.0,
      iconTheme: IconThemeData(),
      actions: <Widget>[
        RawMaterialButton(
          elevation: 0.0,
          child: _searchIcon,
          onPressed: () {
            _searchPressed();
          },
          constraints: BoxConstraints.tightFor(
            width: 56,
            height: 56,
          ),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          elevation: 0.0,
          child: const Icon(Icons.add_location),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapView()));
          },
          constraints: BoxConstraints.tightFor(
            width: 56,
            height: 56,
          ),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          elevation: 0.0,
          child: const Icon(Icons.favorite),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FavoriteScreen()));
          },
          constraints: BoxConstraints.tightFor(
            width: 56,
            height: 56,
          ),
          shape: CircleBorder(),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(bottom: 15),
        centerTitle: true,
        title: isSearchClicked
            ? Container(
                constraints: BoxConstraints(minHeight: 80, maxHeight: 80),
                width: 220,
                child: SearchBar<Product>(
                  hintText: "Search..",
                  icon: Icon(
                    Icons.search,
                  ),
                  listPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  onSearch: _getItemsByName,
                  searchBarController: _searchBarController,
                  cancellationWidget: Icon(
                    CupertinoIcons.clear_thick_circled,
                  ),
                  emptyWidget: Text("empty"),
                  indexedScaledTileBuilder: (int index) =>
                      ScaledTile.count(1, index.isEven ? 2 : 1),
                  onCancelled: () {
                    print("Cancelled triggered");
                  },
                  searchBarStyle: SearchBarStyle(
                    borderRadius: BorderRadius.circular(8.0),
                    backgroundColor: Colors.white,
                  ),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  onItemFound: (Product product, int index) {
                    return Container(
                      child: ListTile(
                        title: Text(product.name),
                        isThreeLine: true,
                        subtitle: Text(product.name),
                        onTap: () {
                          print('clicked');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                    item: product,
                                  )));
                        },
                      ),
                    );
                  },
                ),
              )
            : Text(
                'Total Points ' + '${_totalPoint.toStringAsFixed(2)}\&' ??
                    'default value',
              ),
        background: Container(
          decoration: BoxDecoration(
              color: animatedTextExample.color,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/BodhiLeaf.png"))),
          child: Center(child: animatedTextExample.child),
          height: 300.0,
          width: 300.0,
        ),
      ),
    );
  }
}
