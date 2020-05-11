import 'dart:convert';
import 'dart:io';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'extensions.dart';

class LocalizationTools {
  /// Возвращает поддерживаемые языки приложением в формате `locale`: `locale_name`.
  static Future<Map<Locale, String>> getSupportedLocales(
    BuildContext context, [
    String path = 'resources/lang',
  ]) async {
    path += '/';

    String manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    Map<String, dynamic> manifestMap = json.decode(manifestContent);

    List<String> localesPaths = manifestMap.keys
        .where((String key) => key.contains(path))
        .where((String key) => key.contains('.json'))
        .toList();

    RegExp localeFile = RegExp(r'([a-z]{2})(\-([A-Z]{2}))?\.json');
    var locales = Map<Locale, String>();

    for (String localesPath in localesPaths) {
      RegExpMatch match = localeFile.firstMatch(localesPath);
      Locale locale = Locale(match.group(1), match.group(3));
      String localeData =
          await rootBundle.loadString('$path${locale.toLanguageTag()}.json');

      String localeName = json.decode(localeData)['language'];
      locales[locale] = localeName;
    }
    return locales;
  }

  /// Возвращает наиболее подходящий язык для пользователя,
  /// основываясь на локализации устройства.
  static Future<Locale> recommendedLocale(List<Locale> supportedLocales) async {
    String localeLanguage;
    if (Platform.isAndroid || Platform.isIOS)
      localeLanguage =
          (await Devicelocale.currentLocale).toLocale().languageCode;
    else
      localeLanguage = 'en';

    return supportedLocales.contains(Locale(localeLanguage))
        ? Locale(localeLanguage)
        : Locale('en');
  }
}
