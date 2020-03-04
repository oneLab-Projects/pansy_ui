import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import 'localizations_delegates.dart';

/// [AppLocalizations] предназначен для работы с мультиязычностью приложения.
class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, dynamic> _sentences;

  /// Загружает локализацию из директории, указанной по умолчанию.
  Future<bool> load() async {
    String localeData = await rootBundle
        .loadString('resources/lang/${locale.toLanguageTag()}.json');
    Map<String, dynamic> _result = json.decode(localeData);

    _sentences = Map();
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value;
    });

    return true;
  }

  /// Получает строку на основе проинициализированной локализации.
  String tr(String key, {List<String> args}) {
    String res = _resolve(key, _sentences);
    if (args != null) {
      args.forEach((String str) {
        res = res.replaceFirst(RegExp(r'{}'), str);
      });
    }
    return res;
  }

  String _resolve(String path, dynamic obj) {
    List<String> keys = path.split('.');

    if (keys.length > 1) {
      for (int index = 0; index <= keys.length; index++) {
        if (obj.containsKey(keys[index]) && obj[keys[index]] is! String) {
          return _resolve(
              keys.sublist(index + 1, keys.length).join('.'), obj[keys[index]]);
        }

        return obj[path] ?? path;
      }
    }

    return obj[path] ?? path;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  /// Возвращает true, если локализация поддерживатся в приложении.
  @override
  bool isSupported(Locale locale, [BuildContext context]) {
    return LocalizationsDelegates.getInstance(context).isSupported(locale);
  }

  /// Загружает указанную локализацию.
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  /// Возвращает true, если ресурсы для этого делегата должны быть загружены снова путем вызова метода [load].
  ///
  /// Этот метод вызывается всякий раз, когда его виджет [AppLocalizations] перестраивается.
  /// Если он возвращает true, то зависимые виджеты будут перестроены после завершения [load].
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
