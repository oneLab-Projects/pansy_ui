import 'package:flutter/material.dart';
import 'bloc.dart';

class ThemeProvider extends InheritedWidget {
  final ThemeBloc bloc = ThemeBloc();
  bool updateShouldNotify(_) => true;

  ThemeProvider({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  static ThemeBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ThemeProvider>()).bloc;
  }
}
