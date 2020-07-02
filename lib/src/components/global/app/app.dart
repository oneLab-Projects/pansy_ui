import 'package:pansy_ui/pansy_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

const TextStyle _errorTextStyle = TextStyle(
  color: Color(0xD0FF0000),
  fontFamily: 'monospace',
  fontSize: 48.0,
  fontWeight: FontWeight.w900,
  decoration: TextDecoration.underline,
  decorationColor: Color(0xFFFFFF00),
  decorationStyle: TextDecorationStyle.double,
);

class PansyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget home;
  final Map<String, WidgetBuilder> routes;
  final String initialRoute;
  final RouteFactory onGenerateRoute;
  final InitialRouteListFactory onGenerateInitialRoutes;
  final RouteFactory onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;
  final TransitionBuilder builder;
  final String title;
  final GenerateAppTitle onGenerateTitle;
  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;
  final Color color;
  final Locale locale;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final LocaleListResolutionCallback localeListResolutionCallback;
  final LocaleResolutionCallback localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent> shortcuts;
  final bool debugShowMaterialGrid;

  PansyApp({
    Key key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
  })  : assert(routes != null),
        assert(navigatorObservers != null),
        assert(title != null),
        assert(debugShowMaterialGrid != null),
        assert(showPerformanceOverlay != null),
        assert(checkerboardRasterCacheImages != null),
        assert(checkerboardOffscreenLayers != null),
        assert(showSemanticsDebugger != null),
        assert(debugShowCheckedModeBanner != null),
        super(key: key);

  @override
  _PansyAppState createState() => _PansyAppState();
}

class _PansyAppState extends State<PansyApp> {
  HeroController _heroController;

  @override
  void initState() {
    super.initState();
    _heroController = HeroController(createRectTween: _createRectTween);
    _updateNavigator();
  }

  @override
  void didUpdateWidget(PansyApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.navigatorKey != oldWidget.navigatorKey) {
      _heroController = HeroController(createRectTween: _createRectTween);
    }
    _updateNavigator();
  }

  List<NavigatorObserver> _navigatorObservers;

  void _updateNavigator() {
    if (widget.home != null ||
        widget.routes.isNotEmpty ||
        widget.onGenerateRoute != null ||
        widget.onUnknownRoute != null) {
      _navigatorObservers =
          List<NavigatorObserver>.from(widget.navigatorObservers)
            ..add(_heroController);
    } else {
      _navigatorObservers = const <NavigatorObserver>[];
    }
  }

  RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  void _setSystemUIOverlayStyleFromTheme(ThemeData theme) {
    Brightness brightness;

    if (theme.brightness == Brightness.light) {
      brightness = Brightness.dark;
    } else {
      brightness = Brightness.light;
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: brightness,
      statusBarColor: Colors.transparent,
    ));
  }

  Widget _buildDebugBanner(
      Widget child, BuildContext context, ThemeData theme) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        child,
        SizedBox(
          height: MediaQuery.of(context).padding.top,
          child: Center(
            child: Text(
              ' •  •  •   Debug   •  •  • ',
              style: theme.textTheme.bodyText1.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
      ],
    );
  }

  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates sync* {
    if (widget.localizationsDelegates != null) {
      yield* widget.localizationsDelegates;
    }
    yield DefaultMaterialLocalizations.delegate;
    yield DefaultCupertinoLocalizations.delegate;
  }

  @override
  Widget build(BuildContext context) {
    Widget result = ThemeProvider(
      initialThemeMode: widget.themeMode,
      builder: (themeMode) {
        return WidgetsApp(
          key: GlobalObjectKey(this),
          navigatorKey: widget.navigatorKey,
          navigatorObservers: _navigatorObservers,
          pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
            return MaterialPageRoute<T>(settings: settings, builder: builder);
          },
          home: widget.home,
          routes: widget.routes,
          initialRoute: widget.initialRoute,
          onGenerateRoute: widget.onGenerateRoute,
          onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
          onUnknownRoute: widget.onUnknownRoute,
          builder: (BuildContext context, Widget child) {
            ThemeData theme;
            if (widget.darkTheme != null) {
              final platformBrightness =
                  MediaQuery.platformBrightnessOf(context);
              if (themeMode == ThemeMode.dark ||
                  (themeMode == ThemeMode.system &&
                      platformBrightness == Brightness.dark)) {
                theme = widget.darkTheme;
              }
            }
            theme ??= widget.theme ?? ThemeData.fallback();

            _setSystemUIOverlayStyleFromTheme(theme);

            if (widget.debugShowCheckedModeBanner) {
              child = _buildDebugBanner(child, context, theme);
            }

            return AnimatedTheme(
              data: theme,
              isMaterialAppTheme: true,
              child: widget.builder != null
                  ? Builder(
                      builder: (BuildContext context) {
                        return widget.builder(context, child);
                      },
                    )
                  : child,
            );
          },
          title: widget.title,
          onGenerateTitle: widget.onGenerateTitle,
          textStyle: _errorTextStyle,
          color: widget.color ?? widget.theme?.primaryColor ?? Colors.blue,
          locale: widget.locale,
          localizationsDelegates: _localizationsDelegates,
          localeResolutionCallback: widget.localeResolutionCallback,
          localeListResolutionCallback: widget.localeListResolutionCallback,
          supportedLocales: widget.supportedLocales,
          showPerformanceOverlay: widget.showPerformanceOverlay,
          checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
          showSemanticsDebugger: widget.showSemanticsDebugger,
          debugShowCheckedModeBanner: false,
          inspectorSelectButtonBuilder:
              (BuildContext context, VoidCallback onPressed) {
            return FloatingActionButton(
              child: const Icon(Icons.search),
              onPressed: onPressed,
              mini: true,
            );
          },
          shortcuts: widget.shortcuts,
        );
      },
    );

    assert(() {
      if (widget.debugShowMaterialGrid) {
        result = GridPaper(
          color: Color(0x50F9BBE0),
          interval: 8.0,
          divisions: 2,
          subdivisions: 1,
          child: result,
        );
      }
      return true;
    }());

    return result;
  }
}
