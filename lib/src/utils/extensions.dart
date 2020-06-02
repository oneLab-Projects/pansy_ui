import 'package:flutter/widgets.dart';

extension SeparatedWidgets on List {
  List<Widget> separated(Widget widget) {
    var result = <Widget>[];

    for (var i = 0; i < length; i++) {
      if (i != 0) result.add(widget);
      result.add(this[i]);
    }

    return result;
  }

  List<Widget> ifNull(Widget widget) {
    if (length == 0) add(widget);
    return this;
  }
}
