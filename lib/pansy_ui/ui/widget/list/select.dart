import 'package:flutter/widgets.dart';
import 'package:pansy_ui/pansy_ui.dart';

/// Создаёт виджет выбора, предназначенный для отображения
/// в списке.
class UListSelect extends StatelessWidget {
  UListSelect(
    this.caption, {
    this.description,
    this.value,
    this.iconData,
    this.onPressed,
  });

  final String caption;
  final String description;
  final String value;
  final IconData iconData;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return UListWidget(caption,
        iconData: iconData,
        onPressed: onPressed,
        description: description,
        control: Text(
            value ?? AppLocalizations.of(context).tr('default.not_selected')));
  }
}
