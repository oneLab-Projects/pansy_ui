import 'dart:convert';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pansy_ui/pansy_ui.dart';
import 'package:provider/provider.dart';

import 'app_localizations.dart';

/// Фабрика для набора локализованных ресурсов, загружаемых виджетом [AppLocalizations].
class LocalizationsDelegates {
  LocalizationsDelegates(BuildContext context) {
    _supportedLocales =
        Provider.of<LocalizationsBloc>(context).supportedLocales;
  }

  static LocalizationsDelegates _instance;

  /// Хранит перечисление поддерживаемых локалей в формате `locale`: `locale_name`.
  Map<Locale, String> _supportedLocales;

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

  List<LocalizationsDelegate<dynamic>> _localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// Возвращает наиболее подходящий язык для пользователя,
  /// основываясь на локализации устройства.
  Future<Locale> recommendedLocale(BuildContext context) async {
    _supportedLocales ??= await getSupportedLocales(context);
    Locale locale = (await Devicelocale.currentLocale).toLocale;

    return _supportedLocales.containsKey(locale) ? locale : Locale('en');
  }

  bool isSupported(Locale locale) => _supportedLocales.containsKey(locale);

  static LocalizationsDelegates getInstance(BuildContext context) {
    _instance ??= LocalizationsDelegates(context);
    return _instance;
  }

  List<LocalizationsDelegate> get localizationsDelegates =>
      _localizationsDelegates;

  List<Locale> get supportedLocales => _supportedLocales.keys.toList();
  Map<Locale, String> get supportedLocalesWithName => _supportedLocales;
}
