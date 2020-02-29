import 'package:flutter/material.dart';
import 'bloc.dart';

class LocalizationsProvider extends InheritedWidget {
  final LocalizationsBloc bloc = LocalizationsBloc();
  bool updateShouldNotify(_) => true;

  LocalizationsProvider({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  static LocalizationsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<LocalizationsProvider>())
        .bloc;
  }
}
