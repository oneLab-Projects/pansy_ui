import 'package:flutter/material.dart';

import 'package:pansy_ui/pansy_ui.dart';
import 'package:pansy_ui/pansy_ui/ui/global/bloc.dart';
import 'package:provider/provider.dart';
import '../app_localizations.dart';
import '../localizations_delegates.dart';

/// Страница `Язык интерфейса`.
class LocalizationsSettingPage extends StatefulWidget {
  @override
  _LocalizationsSettingPageState createState() =>
      _LocalizationsSettingPageState();
}

class _LocalizationsSettingPageState extends State<LocalizationsSettingPage> {
  LocalizationsDelegates localizations = LocalizationsDelegates.instance;
  Locale locale = Locale(null);

  @override
  void initState() {
    super.initState();
    localizations.recommendedLocale(context).then(
      (value) {
        setState(() => locale = value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var supportedLocalesWithName = localizations.supportedLocalesWithName;
    return UScaffold(
      title: AppLocalizations.of(context).tr('settings.localizations.title'),
      body: Column(
        children: <Widget>[
          UListContent(
            AppLocalizations.of(context)
                .tr('settings.localizations.recommended'),
            variant: true,
            child: _getRecommendedLanguages(context, supportedLocalesWithName),
          ),
          Divider(),
          UListContent(
            AppLocalizations.of(context)
                .tr('settings.localizations.all_languages'),
            variant: true,
            child: _getAllAppLanguages(context, supportedLocalesWithName),
          ),
        ],
      ),
    );
  }

  /// Получает рекомендованные языки.
  Widget _getRecommendedLanguages(
    BuildContext context,
    Map<Locale, String> supportedLocalesWithName,
  ) {
    return Column(
      children: <Widget>[
        if (locale != Locale('en') && locale != Locale(null))
          _buildWidget(
            context,
            supportedLocalesWithName[locale],
            Localizations.localeOf(context) == locale,
          ),
        if (locale == Locale(null))
          _buildWidget(context, "Loading", false, enabled: false),
        _buildWidget(
          context,
          supportedLocalesWithName[Locale('en')],
          Localizations.localeOf(context) == Locale('en'),
        ),
      ],
    );
  }

  /// Получает все языки, поддерживаемые приложением.
  Widget _getAllAppLanguages(
    BuildContext context,
    Map<Locale, String> supportedLocalesWithName,
  ) {
    return Column(
      children: List.generate(supportedLocalesWithName.length, (int index) {
        bool checked = Localizations.localeOf(context) ==
            supportedLocalesWithName.keys.toList()[index];
        return _buildWidget(
          context,
          supportedLocalesWithName.values.toList()[index],
          checked,
        );
      }),
    );
  }

  Widget _buildWidget(
    BuildContext context,
    String title,
    bool checked, {
    bool enabled = true,
  }) {
    var bloc = Provider.of<LocalizationsBloc>(context);
    return InkWell(
      onTap: () {
        if (!enabled || checked) return;
        var supportedLocalesWithName = localizations.supportedLocalesWithName;
        Locale result = supportedLocalesWithName.keys
            .firstWhere((key) => supportedLocalesWithName[key] == title);

        bloc.changeLocale(result);
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 55),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: Theme.of(context).textTheme.button.color,
                      ),
                ),
              ),
              if (checked) Icon(Icons.check),
            ],
          ),
        ),
      ),
    );
  }
}
