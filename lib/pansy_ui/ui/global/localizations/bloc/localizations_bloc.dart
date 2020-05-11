import 'package:flutter/widgets.dart';
import 'package:pansy_ui/pansy_ui/util/localizations.dart';
import 'package:rxdart/rxdart.dart';

/// Создаёт BLoC (RxDart) для хранения поддерживаемых локалей и рекомендуемой локали.
class LocalizationsBloc {
  Map<Locale, String> supportedLocales;
  Locale recommendedLocale;
  final BehaviorSubject<bool> _statusStream =
      BehaviorSubject<bool>.seeded(false);

  LocalizationsBloc(BuildContext context, [String path]) {
    LocalizationTools.getSupportedLocales(context, path).then((value) {
      supportedLocales = value;
      LocalizationTools.recommendedLocale(supportedLocales.keys.toList()).then(
        (value) {
          recommendedLocale = value;
          _statusStream.sink.add(true);
        },
      );
    });
  }

  Stream<bool> get isLoaded => _statusStream.stream;

  void dispose() => _statusStream.close();
}
