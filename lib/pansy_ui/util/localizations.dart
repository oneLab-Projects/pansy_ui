import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/widgets.dart';
import 'extensions.dart';

class LocalizationTools {
  /// Возвращает наиболее подходящий язык для пользователя,
  /// основываясь на локализации устройства.
  static Future<Locale> recommendedLocale(List<Locale> supportedLocales) async {
    String localeLanguage =
        (await Devicelocale.currentLocale).toLocale().languageCode;

    return supportedLocales.contains(Locale(localeLanguage))
        ? Locale(localeLanguage)
        : Locale('en');
  }
}
