import 'package:flutter/material.dart';

/// Создаёт визуальный элемент переключателя.
class USwitchVisual extends StatefulWidget {
  USwitchVisual(this.value);
  final bool value;

  @override
  _USwitchVisualState createState() => _USwitchVisualState();
}

class _USwitchVisualState extends State<USwitchVisual> {
  Duration _duration = Duration(milliseconds: 150);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _duration,
      curve: Curves.ease,
      width: 40,
      height: 20,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: widget.value
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: AnimatedContainer(
        duration: _duration,
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: widget.value ? Offset(-1, 1) : Offset(1, 1),
              blurRadius: 3,
            ),
          ],
        ),
      ),
    );
  }
}
