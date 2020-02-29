import 'package:flutter/material.dart';

import 'package:pansy_ui/pansy_ui.dart';

/// Создаёт кнопку, предназначенную для отображения
/// в списке.
class UListButton extends StatelessWidget {
  UListButton(
    this.caption, {
    this.description,
    this.iconData,
    this.onPressed,
    this.onLongPress,
  });

  final String caption;
  final String description;
  final IconData iconData;
  final Function onLongPress;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return UListWidget(
      caption,
      iconData: iconData,
      onPressed: onPressed,
      onLongPress: onLongPress,
      description: description,
      control: Icon(
        Icons.arrow_forward_ios,
        size: 15,
        color: Theme.of(context).textTheme.button.color,
      ),
    );
  }
}
