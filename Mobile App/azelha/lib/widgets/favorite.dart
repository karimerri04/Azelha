import 'package:azelha/contsants/colors.dart';
import 'package:azelha/data/bloc/product.bloc.dart';
import 'package:azelha/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget {
  final Product item;
  FavoriteWidget({@required this.item});
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  final _bloc = new ProductBloc();
  bool _isFavorite = false;
  int _favoriteCount = 0;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.item.isFavorite;
  }

  void _toggleFavorite() async {
    setState(() {
      if (_isFavorite) {
        _favoriteCount -= 1;
        _isFavorite = false;
        _bloc.toggleFavorite(widget.item.id, _isFavorite.toString());
      } else {
        _favoriteCount += 1;
        _isFavorite = true;
        _bloc.toggleFavorite(widget.item.id, _isFavorite.toString());
      }
      print(_isFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border)),
            color: primaryColor,
            onPressed: _toggleFavorite,
          ),
        ),
      ],
    );
  }
// #docregion _FavoriteWidgetState-fields
}
