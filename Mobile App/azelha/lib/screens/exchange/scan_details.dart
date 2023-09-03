import 'package:azelha/contsants/colors.dart';
import 'package:azelha/contsants/dialog_utils.dart';
import 'package:azelha/data/bloc/article_bloc.dart';
import 'package:azelha/data/model/article_model.dart';
import 'package:azelha/data/model/scan_model.dart';
import 'package:flutter/material.dart';

class ScanDetails extends StatefulWidget {
  final Scan item;
  ScanDetails({@required this.item});
  @override
  State<StatefulWidget> createState() => ItemDetails();
}

class ItemDetails extends State<ScanDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _controller = ScrollController();
  final _articleBloc = new ArticleBloc();
  List<Article> _articles;
  double _totalAmount = 0.0;
  @override
  void initState() {
    super.initState();
    retrieveArticlesFromBackend().then((data) {
      setState(() {
        _articles = data;
        calculateTotal().then((data) {
          setState(() {
            _totalAmount = data;
          });
        });
      });
    });
  }

  Future retrieveArticlesFromBackend() async {
    await _articleBloc.getArticleByScanId(widget.item.id);
    _articles = await _articleBloc.articleController.first;
    return _articles;
  }

  Future calculateTotal() async {
    for (final article in _articles) {
      _totalAmount = _totalAmount + article.points;
    }
    return _totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    if (_articles.length > 0) {
      return new Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                color: primaryLightColor,
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ],
          ), // here the desired height
        ),
        //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
        body: new Container(
          constraints: BoxConstraints(
            maxHeight: 700.0,
          ),
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
/*                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Container(
                          child: Image.asset('assets/27100763.jpg'),
                        ),
                      ),*/
                      ListTile(
                        leading: Image.asset('assets/27100763.jpg'),
                        title: Text(widget.item.scanNumber),
                        subtitle: Text(
                          widget.item.status,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.item.scanDate,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Summary',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Divider(
                                          height: 1.0,
                                        ),
                                      ),
                                      ListView.builder(
                                          controller: _controller,
                                          shrinkWrap: true,
                                          itemCount: _articles.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return new InkWell(
                                              child: FutureBuilder<double>(
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<double>
                                                              snapshot) {
                                                switch (
                                                    snapshot.connectionState) {
                                                  case ConnectionState.waiting:
                                                    return const CircularProgressIndicator();
                                                  default:
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                    }
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 3.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            _articles[index]
                                                                    .barcode_number
                                                                    .toString() ??
                                                                'default value',
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              width: 15.0,
                                                            ),
                                                          ),
                                                          Text(
                                                            _articles[index]
                                                                    .points
                                                                    .toString() ??
                                                                'default value',
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                }
                                              }),
                                            );
                                          }),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
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
                                    ])),
                          ),
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
      );
    } else {
      return DialogUtils.showCircularProgressBar();
    }
  }
}
