import 'package:flutter/widgets.dart';

abstract class BaseBloc with ChangeNotifier{
  void dispose();
}

class BlocProvider<T extends BaseBloc> extends InheritedWidget {
  BlocProvider({@required this.child, @required this.bloc});

  final T bloc;
  final Widget child;


  static T of<T extends BaseBloc>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

