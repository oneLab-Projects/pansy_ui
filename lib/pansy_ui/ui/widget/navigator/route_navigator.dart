import 'package:flutter/material.dart';
import 'package:pansy_ui/pansy_ui.dart';

class RouteNavigator {
  /// Callback-генератор маршрутов. Используется, когда приложение перемещается по названному маршруту.
  static Route<dynamic> onGenerateRoute(
    RouteSettings settings,
    Map<String, Widget> routes, [
    Function routeBuilder,
  ]) {
    var key = routes.keys
        .firstWhere((key) => key == settings.name, orElse: () => null);
    if (key == null) throw UnsupportedError('Unknown route: ${settings.name}');

    return UPageRoute(
        builder: (context) => settings.name == '/' && routeBuilder != null
            ? routeBuilder(context)
            : routes[key],
        settings: settings);
  }
}
