import 'package:azelha/contsants/colors.dart';
import 'package:azelha/data/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final Product item;

  ProductDetails({@required this.item});

  @override
  State<StatefulWidget> createState() => ItemDetails();
}

class ItemDetails extends State<ProductDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SafeArea(
        child: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Container(
                          child: Image.asset(
                            widget.item.defaultImage,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Image.asset('assets/27100763.jpg'),
                        title: Text(widget.item.name),
                        subtitle: Text(
                          widget.item.description,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Price ' +
                                  '${widget.item.listPrice.toStringAsFixed(2)}\&' ??
                              'default value',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          FlatButton(
                            textColor: secondaryTextColor,
                            color: primaryDarkColor,
                            onPressed: () {
                              // Perform some action
                            },
                            child: const Text('ACTION 1'),
                          ),
                          FlatButton(
                            textColor: primaryDarkColor,
                            color: secondaryTextColor,
                            onPressed: () {
                              // Perform some action
                            },
                            child: const Text('ACTION 2'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
