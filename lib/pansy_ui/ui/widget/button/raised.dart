import 'package:flutter/material.dart';

/// Создаёт приподнятую кнопку.
class URaisedButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function onPressed;
  final Function onLongPress;
  final bool loading;

  URaisedButton(
    Key key,
    this.text, {
    this.iconData,
    @required this.onPressed,
    this.onLongPress,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: onPressed != null ? 1 : 0.9,
      duration: Duration(milliseconds: 150),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).primaryColor,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: loading ? null : onPressed,
          onLongPress: loading ? null : onLongPress,
          child: _buildContent(context),
        ),
      ),
    );
  }

  /// Создаёт содержимое кнопки.
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (text != null && !loading) _buildText(context),
          if (iconData != null && !loading) _buildIcon(context),
        ],
      ),
    );
  }

  /// Создаёт иконку кнопки.
  Widget _buildIcon(BuildContext context) {
    return Icon(
      iconData,
      color: onPressed == null
          ? Theme.of(context).disabledColor.withAlpha(150)
          : Theme.of(context).disabledColor,
    );
  }

  /// Создаёт текст кнопки.
  Widget _buildText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.button.copyWith(
              color: onPressed == null
                  ? Theme.of(context).disabledColor.withAlpha(150)
                  : Theme.of(context).disabledColor,
            ),
      ),
    );
  }
}
