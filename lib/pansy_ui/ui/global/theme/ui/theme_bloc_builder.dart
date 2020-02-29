import 'package:flutter/material.dart';
import '../../bloc.dart';

/// [ThemeBlocBuilder] является виджетом, содержавший в себе Provider и Builder
/// BLoC, предназначенного для смены темы приложения.
class ThemeBlocBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeData themeData) builder;

  ThemeBlocBuilder({@required this.builder}) : assert(builder != null);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: StreamBuilder(
        stream: ThemeProvider.of(context).theme,
        builder: (context, AsyncSnapshot<ThemeData> snapshot) {
          return builder(context, snapshot.data);
        },
      ),
    );
  }
}
