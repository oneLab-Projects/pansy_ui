import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rxdart/rxdart.dart';

/// Создаёт BLoC (RxDart) для реализации смены темы в приложении.
class ThemeBloc {
  static const String _NIGHT_THEME = "ThemeBloc_NIGHT_THEME";
  SharedPreferences _preferences;
  ThemeData _dayTheme;
  ThemeData _nightTheme;

  BehaviorSubject<ThemeData> _subjectTheme;

  ThemeBloc({ThemeData dayTheme, ThemeData nightTheme}) {
    _dayTheme = dayTheme;
    _nightTheme = nightTheme;

    _subjectTheme = BehaviorSubject<ThemeData>.seeded(_dayTheme);
    _loadSettings();
  }

  /// Возвращает поток, содержащий информацию о заданной в приложении темы.
  Stream<ThemeData> get theme => _subjectTheme.stream;

  /// Задаёт, активирована ли ночная тема в приложении.
  set activatedNightTheme(bool value) {
    ThemeData theme = value ? _dayTheme : _nightTheme;
    _subjectTheme.sink.add(theme);
    _saveSettings(value);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: value ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: theme.scaffoldBackgroundColor,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Возвращает, активирована ли ночная тема в приложении.
  bool get isNightTheme => _subjectTheme.value == _nightTheme;

  /// Загружает настройки темы.
  void _loadSettings() async {
    _preferences ??= await SharedPreferences.getInstance();
    bool value = _preferences.getBool(_NIGHT_THEME) ?? false;
    activatedNightTheme = value;
  }

  /// Сохраняет настройки темы.
  void _saveSettings(bool nightTheme) async {
    _preferences ??= await SharedPreferences.getInstance();
    await _preferences.setBool(_NIGHT_THEME, nightTheme);
  }

  void dispose() => _subjectTheme.close();
}
