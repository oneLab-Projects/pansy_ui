import 'package:flutter/widgets.dart';
import 'package:pansy_ui/pansy_ui/util/localizations.dart';
import 'package:rxdart/rxdart.dart';

/// Создаёт BLoC (RxDart) для хранения поддерживаемых локалей и рекомендуемой локали.
class LocalizationsBloc {
  Map<Locale, String> supportedLocales;
  Locale recommendedLocale;
  BehaviorSubject<bool> _statusStream = BehaviorSubject<bool>.seeded(false);

  LocalizationsBloc(Map<Locale, String> languages) {
    supportedLocales = languages;
    LocalizationTools.recommendedLocale(supportedLocales.keys.toList())
        .then((value) {
      recommendedLocale = value;
      _statusStream.sink.add(true);
    });
  }

  Stream<bool> get isLoaded => _statusStream.stream;

  void dispose() => _statusStream.close();
}