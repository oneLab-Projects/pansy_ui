import 'package:flutter/widgets.dart';
import '../bloc/bloc.dart';
import '../localizations_delegates.dart';

/// [LocalizationsBlocBuilder] является виджетом, содержавший в себе Provider и Builder
/// BLoC, предназначенного для смены локализации приложения.
class LocalizationsBlocBuilder extends StatelessWidget {
  final Widget Function(
      BuildContext context,
      Locale locale,
      List<Locale> supportedLocales,
      List<LocalizationsDelegate> localizationsDelegates) builder;

  LocalizationsBlocBuilder({@required this.builder}) : assert(builder != null);

  @override
  Widget build(BuildContext context) {
    return LocalizationsProvider(
      child: StreamBuilder(
        stream: LocalizationsProvider.of(context).locale,
        builder: (context, AsyncSnapshot<Locale> snapshot) {
          return builder(
            context,
            snapshot.data,
            LocalizationsDelegates.instance.supportedLocales,
            LocalizationsDelegates.instance.localizationsDelegates,
          );
        },
      ),
    );
  }
}
