import 'package:flutter/widgets.dart';
import 'package:pansy_ui/pansy_ui/util/localizations.dart';

/// Создаёт BLoC (RxDart) для хранения поддерживаемых локалей и рекомендуемой локали.
class LocalizationsBloc {
  Map<Locale, String> supportedLocales;
  Locale recommendedLocale;

  LocalizationsBloc(BuildContext context, String path) {
    LocalizationTools.getSupportedLocales(context, path).then((value) {
      supportedLocales = value;
      LocalizationTools.recommendedLocale(supportedLocales.keys.toList()).then(
        (value) => recommendedLocale = value,
      );
    });
  }
}
