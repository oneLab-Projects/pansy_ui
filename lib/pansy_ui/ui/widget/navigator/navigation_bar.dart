import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pansy_ui/pansy_ui.dart';

/// Создаёт элемент нижней панели навигации. Так же принимает
/// `badge` для отображения статуса непрочитанной информации.
class UBottomNavigationBarItem {
  IconData iconData;
  IconData selectedIconData;
  bool badge;

  UBottomNavigationBarItem({
    @required this.iconData,
    this.selectedIconData,
    this.badge = false,
  }) : assert(iconData != null);
}

/// Создаёт нижнюю панель навигации. Так же принимает `body` для
/// правильной координации при изменении ориентации устройства.
class UBottomNavigationBar extends StatefulWidget {
  final List<UBottomNavigationBarItem> items;
  final double iconSize;
  final ValueChanged<int> onTabSelected;

  UBottomNavigationBar({
    Key key,
    @required this.items,
    this.iconSize = 24,
    this.onTabSelected,
  })  : assert(items != null),
        super(key: key);

  static const double heightNavigationBarVertical = 50;
  static const double weightNavigationBarHorisontal = 60;

  /// Возвращает значение выравнивания контента, в зависимости от ориентации
  /// устройства, для корректного отображения `body`.
  static Alignment getAlignment(BuildContext context, Orientation orientation) {
    return (orientation == Orientation.portrait && Device.isPhone(context))
        ? Alignment.bottomCenter
        : Alignment.centerLeft;
  }

  @override
  _UBottomNavigationBarState createState() => _UBottomNavigationBarState();
}

class _UBottomNavigationBarState extends State<UBottomNavigationBar> {
  int _selectedIndex = 0;

  void _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var items = List<Widget>.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return _buildBottomNavigationBar(
        context, items, MediaQuery.of(context).orientation);
  }

  /// Возвращает значение [Border], в зависимости от ориентации устройства.
  Border _alignmentToBorder(Alignment alignment, BorderSide side) {
    if (alignment == Alignment.centerLeft) {
      return Border(right: side);
    } else {
      return Border(top: side);
    }
  }

  /// Создаёт нижнюю панель навигации.
  Widget _buildBottomNavigationBar(
      BuildContext context, List<Widget> items, Orientation orientation) {
    var height = UBottomNavigationBar.getAlignment(context, orientation) ==
            Alignment.bottomCenter
        ? UBottomNavigationBar.heightNavigationBarVertical
        : double.infinity;
    var width = UBottomNavigationBar.getAlignment(context, orientation) ==
            Alignment.bottomCenter
        ? double.infinity
        : UBottomNavigationBar.weightNavigationBarHorisontal;
    var direction = UBottomNavigationBar.getAlignment(context, orientation) ==
            Alignment.bottomCenter
        ? Axis.horizontal
        : Axis.vertical;
    var marginTop = UBottomNavigationBar.getAlignment(context, orientation) ==
            Alignment.bottomCenter
        ? 0
        : MediaQuery.of(context).padding.top;

    return Align(
      alignment: UBottomNavigationBar.getAlignment(context, orientation),
      child: ClipRRect(
        child: Stack(
          children: <Widget>[
            if (Device.isPhone(context))
              SizedBox(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    constraints:
                        BoxConstraints.expand(height: height, width: width),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.5),
                      border: _alignmentToBorder(
                        UBottomNavigationBar.getAlignment(context, orientation),
                        BorderSide(
                          color: Theme.of(context).dividerColor.withAlpha(35),
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Material(
              type: MaterialType.transparency,
              child: Container(
                constraints: BoxConstraints.expand(
                  height: height,
                  width: Device.isPhone(context) ? width : 120,
                ),
                margin: EdgeInsets.only(
                  top: marginTop,
                ),
                child: Center(
                  child: Flex(
                    direction: direction,
                    mainAxisAlignment: Device.isPhone(context)
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.center,
                    children: items,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Создаёт элемент нижней панели навигации.
  Widget _buildTabItem({
    UBottomNavigationBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    var iconData = _selectedIndex == index && item.selectedIconData != null
        ? item.selectedIconData
        : item.iconData;
    return Expanded(
      flex: Device.isPhone(context) ? 1 : 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Device.isPhone(context) ? 0 : 30,
            horizontal: Device.isPhone(context) ? 0 : 30),
        child: SizedBox(
          height: Device.isPhone(context) ? double.infinity : 60,
          child: InkWell(
            splashColor: Colors.black12,
            highlightColor: Colors.black12,
            borderRadius: BorderRadius.circular(5),
            onTap: () => onPressed(index),
            child: Stack(
              children: <Widget>[
                Center(
                    child: Icon(iconData,
                        size: Device.isPhone(context)
                            ? widget.iconSize
                            : widget.iconSize * 1.1)),
                Positioned(
                  bottom: 33,
                  left: 59,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceOut,
                    width: item.badge ? 8 : 0,
                    height: item.badge ? 8 : 0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
