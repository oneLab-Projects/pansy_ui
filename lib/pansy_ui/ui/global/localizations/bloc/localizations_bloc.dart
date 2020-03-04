import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:pansy_ui/pansy_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rxdart/rxdart.dart';

/// Создаёт BLoC (RxDart) для реализации смены локализации в приложении.
class LocalizationsBloc {
  static const String _LOCALE = "LocalizationsBloc_LOCALE";
  SharedPreferences _preferences;

  BehaviorSubject<Locale> _subjectLocale;
  Locale _locale = Locale('en');
  Map<Locale, String> _supportedLocales;

  LocalizationsBloc(BuildContext context) {
    _subjectLocale = BehaviorSubject<Locale>.seeded(_locale);
    _loadSupportLocales(context);
    _loadSettings(context);
  }

  /// Возвращает поток заданной в приложении локализации.
  Stream<Locale> get locale => _subjectLocale.stream;

  /// Возвращает поддерживаемые локализации.
  Map<Locale, String> get supportedLocales => _supportedLocales;

  /// Задаёт локализацию приложения.
  void changeLocale(Locale locale) {
    _subjectLocale.sink.add(locale);
    _saveSettings(locale);
  }

  /// Загружает список поддерживаемых языков.
  void _loadSupportLocales(BuildContext context) async {
    _supportedLocales =
        await LocalizationsDelegates.getSupportedLocales(context);
  }

  /// Загружает настройки локализации.
  void _loadSettings(BuildContext context) async {
    _preferences ??= await SharedPreferences.getInstance();
    Locale locale = (_preferences.getString(_LOCALE) ??
            (await LocalizationsDelegates.getInstance(context)
                .recommendedLocale(context)))
        .toString()
        .toLocale;
    _subjectLocale.sink.add(locale);
  }

  /// Сохраняет настройки локализации.
  Future _saveSettings(Locale locale) async {
    _preferences ??= await SharedPreferences.getInstance();
    await _preferences.setString(_LOCALE, locale.toLanguageTag());
  }

  void dispose() => _subjectLocale.close();
}
