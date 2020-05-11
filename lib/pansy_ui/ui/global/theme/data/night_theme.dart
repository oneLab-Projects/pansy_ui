import 'package:flutter/material.dart';
import 'package:pansy_ui/pansy_ui.dart';

/// Хранит [ThemeData] в стиле ночной темы приложения.
final ThemeData nightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  textTheme: Style.textTheme,
  primaryColor: Colors.grey[200],
  scaffoldBackgroundColor: const Color(0xFF1E1E1E),
  cursorColor: Colors.grey[500],
  disabledColor: const Color(0xFF252525),
  cardColor: const Color(0xFF272727),
  splashColor: Colors.black.withAlpha(25),
  highlightColor: Colors.black.withAlpha(25),
  dividerColor: Colors.black.withAlpha(75),
);
