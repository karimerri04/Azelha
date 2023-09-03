import 'package:azelha/contsants/colors.dart';
import 'package:azelha/contsants/dialog_utils.dart';
import 'package:azelha/data/bloc/base_bloc.dart';
import 'package:azelha/data/bloc/product.bloc.dart';
import 'package:azelha/data/model/product_model.dart';
import 'package:azelha/widgets/favorite.dart';
import 'package:flutter/material.dart';

import 'product_details.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final _bloc = new ProductBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getFavoriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.15;
    final double itemWidth = size.width / 2;

    return BlocProvider<ProductBloc>(
      bloc: _bloc,
      child: Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(0.0),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      color: primaryColor,
                      child: GridView.count(
                        crossAxisCount: 2,
                        padding: const EdgeInsets.all(4.0),
                        childAspectRatio: (itemWidth / itemHeight),
                        controller:
                            new ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: snapshot.data.map((Product item) {
                          return ProductItem(
                            destination: item,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ]);
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Some error..."),
              );
            } else {
              return DialogUtils.showCircularProgressBar();
            }
          },
          stream: _bloc.productFavoriteStream,
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  ProductItem({Key key, @required this.destination, this.shape})
      : assert(destination != null),
        super(key: key);
  static const double height = 566.0;
  final Product destination;
  final ShapeBorder shape;

  String toolbarname = 'Products';

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: false,
      bottom: false,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        height: height,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetails(
                          item: destination,
                        )));
          },
          child: Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // photo and title
                  Container(
                    height: 150.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          top: 10.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                            child: Image.asset(
                              destination.defaultImage.toString(),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: FavoriteWidget(item: destination),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Divider(),
                          Text(
                            destination.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: kTextSecondary),
                          ),
                          Text(
                            '550g',
                            maxLines: 1,
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Divider(),
                          Text(
                            destination.listPrice.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                fontSize: kTextSecondary),
                          ),
                        ],
                      ),
                    ),
                  ) // share, explore buttons
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
