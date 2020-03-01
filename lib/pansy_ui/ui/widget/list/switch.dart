import 'package:flutter/widgets.dart';
import 'package:pansy_ui/pansy_ui.dart';

/// Создаёт переключатель, предназначенный для отображения
/// в списке.
class UListSwitch extends StatefulWidget {
  final String caption;
  final String description;
  final IconData iconData;
  final Function(bool) onChanged;
  final bool value;

  UListSwitch(
    this.caption, {
    this.description,
    this.iconData,
    @required this.onChanged,
    @required this.value,
  }) : assert(value != null);

  @override
  _UListSwitchState createState() => _UListSwitchState();
}

class _UListSwitchState extends State<UListSwitch> {
  @override
  Widget build(BuildContext context) {
    return UListWidget(
      widget.caption,
      description: widget.description,
      iconData: widget.iconData,
      onPressed: widget.onChanged == null
          ? null
          : () => widget.onChanged(!widget.value),
      control: USwitchVisual(widget.value),
    );
  }
}
