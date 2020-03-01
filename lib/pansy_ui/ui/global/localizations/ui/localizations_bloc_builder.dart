import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../bloc/bloc.dart';
import '../localizations_delegates.dart';

/// [LocalizationsBlocBuilder] является виджетом, содержавший в себе Provider и Builder
/// BLoC, предназначенного для смены локализации приложения.
class LocalizationsBlocBuilder extends StatefulWidget {
  final Widget Function(
      BuildContext context,
      Locale locale,
      List<Locale> supportedLocales,
      List<LocalizationsDelegate> localizationsDelegates) builder;

  LocalizationsBlocBuilder({@required this.builder}) : assert(builder != null);

  @override
  _LocalizationsBlocBuilderState createState() =>
      _LocalizationsBlocBuilderState();
}

class _LocalizationsBlocBuilderState extends State<LocalizationsBlocBuilder> {
  List<Locale> _locales;

  @override
  void initState() {
    super.initState();
    LocalizationsDelegates.getSupportedLocales(context)
        .then((value) => _locales = value.keys.toList());
  }

  @override
  Widget build(BuildContext context) {
    var bloc = LocalizationsBloc(context);
    return ProxyProvider0<LocalizationsBloc>(
      update: (_, __) => bloc,
      child: StreamBuilder(
        stream: bloc.locale,
        builder: (context, AsyncSnapshot<Locale> snapshot) {
          return widget.builder(
            context,
            snapshot.data,
            _locales,
            LocalizationsDelegates.instance.localizationsDelegates,
          );
        },
      ),
    );
  }
}
