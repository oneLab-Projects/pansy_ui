import 'package:flutter/material.dart';

/// Константы приложения, хранящие к себе информацию,
/// связанную с дизайном приложения.
class Style {
  /// Хранит настроенный под дизайн приложения [TextTheme].
  static const TextTheme textTheme = TextTheme(
    headline6: TextStyle(
      fontFamily: 'Ubuntu',
      fontSize: 19,
    ),
    subtitle1: TextStyle(
      fontFamily: 'Ubuntu',
      fontSize: 13.4,
    ),
    button: TextStyle(
      fontFamily: 'Ubuntu',
      fontSize: 16,
    ),
    caption: TextStyle(
      fontFamily: 'Ubuntu',
      fontSize: 13.4,
    ),
  );
}
