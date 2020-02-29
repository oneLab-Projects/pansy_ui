import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../bloc.dart';

/// [ThemeBlocBuilder] является виджетом, содержавший в себе Provider и Builder
/// BLoC, предназначенного для смены темы приложения.
class ThemeBlocBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeData themeData) builder;

  ThemeBlocBuilder({@required this.builder}) : assert(builder != null);

  @override
  Widget build(BuildContext context) {
    var bloc = ThemeBloc();
    return ProxyProvider0<ThemeBloc>(
      update: (_, __) => bloc,
      child: StreamBuilder(
        stream: bloc.theme,
        builder: (context, AsyncSnapshot<ThemeData> snapshot) {
          return builder(context, snapshot.data);
        },
      ),
    );
  }
}
