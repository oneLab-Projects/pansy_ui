import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pansy_ui/pansy_ui/ui/global/bloc.dart';
import 'package:pansy_ui/pansy_ui/ui/global/theme/data/day_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rxdart/rxdart.dart';

/// Создаёт BLoC (RxDart) для реализации смены темы в приложении.
class ThemeBloc {
  static const String _NIGHT_THEME = "ThemeBloc_NIGHT_THEME";
  SharedPreferences _preferences;

  BehaviorSubject<ThemeData> _subjectNightTheme;
  ThemeData _theme = dayTheme;

  ThemeBloc() {
    _subjectNightTheme = BehaviorSubject<ThemeData>.seeded(_theme);
    _loadSettings();
  }

  /// Возвращает поток, содержащий информацию о заданной в приложении темы.
  Stream<ThemeData> get theme => _subjectNightTheme.stream;

  /// Переключает ночную тему приложения, а также стилизирует
  /// StatusBar и SystemNavigationBar с помощью [SystemChrome].
  void setNightTheme(bool value) {
    ThemeData theme = value ? nightTheme : dayTheme;
    _subjectNightTheme.sink.add(theme);
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

  bool isNightTheme() => _subjectNightTheme.value == nightTheme;

  /// Загружает настройки темы.
  void _loadSettings() async {
    _preferences ??= await SharedPreferences.getInstance();
    bool value = _preferences.getBool(_NIGHT_THEME) ?? false;
    setNightTheme(value);
  }

  /// Сохраняет настройки темы.
  Future _saveSettings(bool nightTheme) async {
    _preferences ??= await SharedPreferences.getInstance();
    await _preferences.setBool(_NIGHT_THEME, nightTheme);
  }

  void dispose() => _subjectNightTheme.close();
}
