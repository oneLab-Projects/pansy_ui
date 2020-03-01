import 'package:flutter/material.dart';

/// Создаёт прозрачную круглую кнопку с иконкой.
class UIconButton extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final double width;
  final double height;
  final GestureTapCallback onPressed;

  UIconButton({
    @required this.iconData,
    this.iconSize = 24,
    this.width = 45,
    this.height = 45,
    @required this.onPressed,
  }) : assert(iconData != null || onPressed != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        customBorder: CircleBorder(),
        child: Icon(
          iconData,
          size: iconSize,
        ),
        onTap: onPressed,
      ),
    );
  }
}
