import 'dart:async';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import '../localizations_delegates.dart';

import 'package:rxdart/rxdart.dart';

/// Создаёт BLoC (RxDart) для реализации смены локализации в приложении.
class LocalizationsBloc {
  static const String _LOCALE = "LocalizationsBloc_LOCALE";
  SharedPreferences _preferences;

  BehaviorSubject<Locale> _subjectLocale;
  Locale _locale = Locale('en');

  LocalizationsBloc() {
    _subjectLocale = BehaviorSubject<Locale>.seeded(this._locale);
    _loadSettings();
  }

  /// Возвращает поток, содержащий информацию о заданной в приложении локализации.
  Stream<Locale> get locale => _subjectLocale.stream;

  /// Задаёт локализацию приложения.
  void changeLocale(Locale locale) {
    _subjectLocale.sink.add(locale);
    _saveSettings(locale);
  }

  /// Загружает настройки локализации.
  void _loadSettings() async {
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(_LOCALE) ??
        (await LocalizationsDelegates.instance.recommendedLocale());
    _subjectLocale.sink.add(Locale(languageCode));
  }

  /// Сохраняет настройки локализации.
  Future _saveSettings(Locale locale) async {
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();
    await _preferences.setString(_LOCALE, locale.languageCode);
  }

  void dispose() => _subjectLocale.close();
}
