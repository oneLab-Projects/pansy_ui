import 'package:flutter/material.dart';
import 'package:pansy_ui/pansy_ui.dart';

/// [UNestedTabModel] является моделью для представления вкладки,
/// работающей с [UNestedNavigator].
class UNestedTabModel {
  final WidgetBuilder initPageBuilder;
  final IconData iconData;
  final IconData selectedIconData;
  final bool badge;
  final GlobalKey<NavigatorState> _navigatorKey;

  UNestedTabModel({
    @required this.initPageBuilder,
    @required this.iconData,
    this.selectedIconData,
    this.badge = false,
    GlobalKey<NavigatorState> navigatorKey,
  })  : _navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>(),
        assert(initPageBuilder != null || iconData != null);
}

/// Создаёт реализацию мультиоконности.
class UNestedNavigator extends StatefulWidget {
  final int initTabIndex;
  final List<UNestedTabModel> tabs;
  final ValueChanged<int> onTap;
  final ValueGetter shouldHandlePop;
  final Map<String, Widget> routes;

  final Color backgroundColor;
  final Color color;
  final Color selectedColor;

  UNestedNavigator({
    Key key,
    @required this.tabs,
    this.initTabIndex = 0,
    this.onTap,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.shouldHandlePop = _defaultShouldHandlePop,
    this.routes,
  })  : assert(tabs != null),
        super(key: key);

  static bool _defaultShouldHandlePop() => true;

  @override
  State<StatefulWidget> createState() => _UNestedNavigatorState(initTabIndex);
}

class _UNestedNavigatorState extends State<UNestedNavigator> {
  int currentIndex;

  _UNestedNavigatorState(this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return widget.shouldHandlePop()
            ? !await widget.tabs[currentIndex]._navigatorKey.currentState
                .maybePop()
            : false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildBottomBarBackground(),
            _buildPageBody(),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  /// Создаёт стек, хранящий в себе все вкладки.
  Widget _buildPageBody() {
    return Padding(
      padding: _getPadding(
        MediaQuery.of(context).orientation,
      ),
      child: AnimatedIndexedStack(
        index: currentIndex,
        children: widget.tabs.map((tab) => _buildNavigator(tab)).toList(),
      ),
    );
  }

  /// Создаёт задний фон нижней панели навигации.
  Widget _buildBottomBarBackground() {
    Orientation orientation;
    orientation = MediaQuery.of(context).orientation;
    double height = UBottomNavigationBar.getAlignment(context, orientation) ==
            Alignment.bottomCenter
        ? UBottomNavigationBar.heightNavigationBarVertical
        : double.infinity;
    double width = UBottomNavigationBar.getAlignment(context, orientation) ==
            Alignment.bottomCenter
        ? double.infinity
        : UBottomNavigationBar.weightNavigationBarHorisontal;
    return Align(
      alignment: UBottomNavigationBar.getAlignment(context, orientation),
      child: Container(
        color: widget.backgroundColor,
        height: height,
        width: width,
      ),
    );
  }

  /// Возвращает значение отступов, в зависимости от ориентации
  /// устройства, для корректного отображения `body`.
  EdgeInsets _getPadding(Orientation orientation) {
    return (orientation == Orientation.portrait && Device.isPhone(context))
        ? const EdgeInsets.only(
            bottom: UBottomNavigationBar.heightNavigationBarVertical)
        : const EdgeInsets.only(
            left: UBottomNavigationBar.weightNavigationBarHorisontal + 15);
  }

  /// Создаёт вкладку.
  Widget _buildNavigator(UNestedTabModel tab) {
    return UNestedTab(
      routes: widget.routes,
      navigatorKey: tab._navigatorKey,
      initPageBuilder: tab.initPageBuilder,
    );
  }

  /// Создаёт нижнюю панель навигации.
  Widget _buildBottomBar() {
    return UBottomNavigationBar(
      onTabSelected: (index) {
        if (widget.onTap != null) widget.onTap(index);
        FocusScope.of(context).unfocus();
        setState(() => currentIndex = index);
      },
      items: widget.tabs
          .map((tab) => UBottomNavigationBarItem(
                iconData: tab.iconData,
                selectedIconData: tab.selectedIconData,
                badge: tab.badge,
              ))
          .toList(),
    );
  }
}

/// Создаёт вкладку, работающую с [UNestedNavigator]
class UNestedTab extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final WidgetBuilder initPageBuilder;
  final Map<String, Widget> routes;

  UNestedTab({
    Key key,
    @required this.navigatorKey,
    @required this.initPageBuilder,
    @required this.routes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      observers: [HeroController()],
      onGenerateRoute: (routeSettings) => routes != null
          ? RouteNavigator.onGenerateRoute(
              routeSettings, routes, initPageBuilder)
          : UPageRoute(
              builder: (context) => initPageBuilder(context),
              settings: routeSettings,
            ),
    );
  }
}
