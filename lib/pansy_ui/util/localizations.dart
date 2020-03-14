import 'dart:convert';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'extensions.dart';

class LocalizationTools {
  /// Возвращает поддерживаемые локали приложением в формате `locale`: `locale_name`.
  static Future<Map<Locale, String>> getSupportedLocales(
    BuildContext context, [
    String directory = 'resources/lang/',
  ]) async {
    String manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    Map<String, dynamic> manifestMap = json.decode(manifestContent);

    List<String> localesPaths = manifestMap.keys
        .where((String key) => key.contains(directory))
        .where((String key) => key.contains('.json'))
        .toList();

    RegExp localeFile = RegExp(r'([a-z]{2})(\-([A-Z]{2}))?\.json');
    var locales = Map<Locale, String>();

    for (String localesPath in localesPaths) {
      RegExpMatch match = localeFile.firstMatch(localesPath);
      Locale locale = Locale(match.group(1), match.group(3));
      String localeData = await rootBundle
          .loadString('$directory${locale.toLanguageTag()}.json');

      String localeName = json.decode(localeData)['language'];
      locales[locale] = localeName;
    }
    return locales;
  }

  /// Возвращает наиболее подходящий язык для пользователя,
  /// основываясь на локализации устройства.
  Future<Locale> recommendedLocale(
      BuildContext context, List<Locale> _supportedLocales) async {
    Locale locale = (await Devicelocale.currentLocale).toLocale();

    return _supportedLocales.contains(locale) ? locale : Locale('en');
  }
}