import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pansy_ui/pansy_ui.dart';

/// Создаёт виджет выбора, предназначенный для отображения
/// в списке.
class UListSelect extends StatelessWidget {
  final String caption;
  final String description;
  final String value;
  final IconData iconData;
  final Function onPressed;

  UListSelect(
    this.caption, {
    this.description,
    @required this.value,
    this.iconData,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return UListWidget(caption,
        iconData: iconData,
        onPressed: onPressed,
        description: description,
        control: Text(value));
  }
}
