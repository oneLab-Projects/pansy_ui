import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../bloc/bloc.dart';
import '../localizations_delegates.dart';

/// [LocalizationsBlocBuilder] является виджетом, содержавший в себе Provider и Builder
/// BLoC, предназначенного для смены локализации приложения.
class LocalizationsBlocBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    Locale locale,
    List<Locale> supportedLocales,
    List<LocalizationsDelegate<dynamic>> localizationsDelegates,
  ) builder;

  LocalizationsBlocBuilder({@required this.builder}) : assert(builder != null);

  @override
  Widget build(BuildContext context) {
    var bloc = LocalizationsBloc(context);
    return ProxyProvider0<LocalizationsBloc>(
      update: (_, __) => bloc,
      child: StreamBuilder(
        stream: bloc.locale,
        builder: (context, AsyncSnapshot<Locale> snapshot) {
          var localizationsDelegates =
              LocalizationsDelegates.getInstance(context);
          return builder(
            context,
            snapshot.data,
            localizationsDelegates.supportedLocales,
            localizationsDelegates.localizationsDelegates,
          );
        },
      ),
    );
  }
}
