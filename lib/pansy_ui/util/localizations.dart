import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/widgets.dart';
import 'extensions.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LocalizationTools {
  /// Возвращает наиболее подходящий язык для пользователя,
  /// основываясь на локализации устройства.
  static Future<Locale> recommendedLocale(List<Locale> supportedLocales) async {
    String localeLanguage;

    if (kIsWeb)
      localeLanguage =
          (await Devicelocale.currentLocale).toLocale().languageCode;
    else
      return Locale('en');

    return supportedLocales.contains(Locale(localeLanguage))
        ? Locale(localeLanguage)
        : Locale('en');
  }
}
