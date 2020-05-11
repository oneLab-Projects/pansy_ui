import 'package:flutter/material.dart';

/// Создаёт визуальный элемент переключателя.
class USwitchVisual extends StatefulWidget {
  final bool value;
  USwitchVisual(this.value);

  @override
  _USwitchVisualState createState() => _USwitchVisualState();
}

class _USwitchVisualState extends State<USwitchVisual> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: widget.value
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
        alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
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
      ),
    );
  }
}
