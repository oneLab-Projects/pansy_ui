import 'package:flutter/material.dart';

typedef ThemedWidgetBuilder = Widget Function(ThemeMode data);

class ThemeProvider extends StatefulWidget {
  const ThemeProvider({
    Key key,
    @required this.initialThemeMode,
    @required this.builder,
  })  : assert(initialThemeMode != null || builder != null),
        super(key: key);

  final ThemeMode initialThemeMode;
  final ThemedWidgetBuilder builder;

  @override
  ThemeProviderState createState() => ThemeProviderState();

  static ThemeProviderState of(BuildContext context) {
    return context.findAncestorStateOfType<State<ThemeProvider>>();
  }
}

class ThemeProviderState extends State<ThemeProvider> {
  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  void setThemeMode(ThemeMode themeMode) {
    setState(() => _themeMode = themeMode);
  }

  void toggleThemeMode() {
    setState(() => _themeMode =
        themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_themeMode);
  }
}
