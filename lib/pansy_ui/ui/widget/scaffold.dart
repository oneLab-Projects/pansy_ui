import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:pansy_ui/pansy_ui.dart';

/// Создает визуальную основу для виджетов.
class UScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final bool blurBackground;
  final bool showBackButton;

  UScaffold({
    this.title,
    @required this.body,
    this.blurBackground = false,
    this.showBackButton = true,
  }) : assert(body != null);

  static const double titleHeight = 60;

  @override
  _UScaffoldState createState() => _UScaffoldState();
}

class _UScaffoldState extends State<UScaffold> {
  ScrollController _scrollController = ScrollController();
  CustomScrollController _backgroundScrollController = CustomScrollController();
  double _scrollPosition = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _backgroundScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: <Widget>[
            if (widget.blurBackground) _buildBlurBackground(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Device.isPhone(context) ? 0 : 28),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 1000),
                    child: Stack(children: [
                      if (!widget.showBackButton)
                        widget.title == null
                            ? _content(context)
                            : _contentWithTitleBar(context),
                      if (widget.showBackButton)
                        _contentWithBackButton(context),
                      Opacity(
                        opacity: _scrollPosition < 1 ? 1 - _scrollPosition : 0,
                        child: Container(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withAlpha(90),
                          height: MediaQuery.of(context).padding.top,
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Создаёт [ScrollView], содержавший в себе анимированный заголовок страницы по центру.
  Widget _contentWithTitleBar(context) {
    return Stack(
      children: <Widget>[
        _titleBar(context),
        NotificationListener<ScrollNotification>(
          onNotification: (scrollState) {
            if ((scrollState is ScrollUpdateNotification ||
                    scrollState is ScrollEndNotification) &&
                widget.blurBackground)
              _backgroundScrollController
                  .jumpToWithoutGoingIdleAndKeepingBallistic(
                      scrollState.metrics.pixels);
            if (scrollState is ScrollUpdateNotification &&
                (UScaffold.titleHeight - scrollState.metrics.pixels) >= 0) {
              setState(() {
                _scrollPosition =
                    (UScaffold.titleHeight - scrollState.metrics.pixels) *
                        100 /
                        UScaffold.titleHeight /
                        100;
              });
            } else if (scrollState is ScrollUpdateNotification &&
                (UScaffold.titleHeight - scrollState.metrics.pixels) < 0)
              setState(() => _scrollPosition = 0);

            if (scrollState is ScrollEndNotification &&
                (UScaffold.titleHeight - scrollState.metrics.pixels) > 0 &&
                _scrollPosition < 1) {
              double step = 0;
              if (_scrollPosition > 0 && _scrollPosition < 0.6)
                step = UScaffold.titleHeight;

              Future.delayed(Duration(milliseconds: 1), () {}).then((s) =>
                  _scrollController.animateTo(step,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease));
            }

            return false;
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                SizedBox(
                    height: Device.isPhone(context)
                        ? UScaffold.titleHeight +
                            MediaQuery.of(context).padding.top
                        : UScaffold.titleHeight +
                            MediaQuery.of(context).padding.top +
                            60),
                widget.body,
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Создаёт размытое отражение `body`.
  Widget _buildBlurBackground(context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1000),
              child: SingleChildScrollView(
                controller: _backgroundScrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                          horizontal: Device.isPhone(context) ? 0 : 28)
                      .copyWith(
                    top: Device.isPhone(context)
                        ? MediaQuery.of(context).padding.top +
                            UScaffold.titleHeight
                        : MediaQuery.of(context).padding.top +
                            UScaffold.titleHeight +
                            60,
                  ),
                  child: widget.body,
                ),
              ),
            ),
          ],
        ),
        SizedBox.expand(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              height: double.maxFinite,
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  /// Создаёт [ScrollView].
  Widget _content(context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          SizedBox(
              height: Device.isPhone(context)
                  ? MediaQuery.of(context).padding.top
                  : MediaQuery.of(context).padding.top + 60),
          widget.body,
        ],
      ),
    );
  }

  /// Создаёт заголовок по центру.
  Widget _titleBar(context) {
    return Opacity(
      opacity: _scrollPosition < 1
          ? _scrollPosition
          : 1 - (_scrollPosition - 1) / _scrollPosition,
      child: Padding(
        padding: EdgeInsets.only(
            top: Device.isPhone(context)
                ? 25 + MediaQuery.of(context).padding.top
                : 70 + MediaQuery.of(context).padding.top,
            left: Device.isPhone(context) ? 0 : 18),
        child: Row(
          mainAxisAlignment: Device.isPhone(context)
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: <Widget>[
            Transform.scale(
              scale: _scrollPosition < 1
                  ? 1 - (1 - _scrollPosition) * 0.3
                  : 1 + (1 - _scrollPosition) / _scrollPosition * 0.15,
              alignment: Device.isPhone(context)
                  ? Alignment.center
                  : Alignment.topLeft,
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: Device.isPhone(context) ? 20 : 30,
                    fontWeight: Device.isPhone(context)
                        ? FontWeight.w500
                        : FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Создаёт [ScrollView], содержавший в себе кнопку возврата на предыдущую страницу, и, если указано, заголовок страницы.
  Widget _contentWithBackButton(context) {
    return Column(
      children: <Widget>[
        SizedBox(
            height: Device.isPhone(context)
                ? MediaQuery.of(context).padding.top
                : MediaQuery.of(context).padding.top + 60),
        _titleBarWithBackButton(context),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: widget.body,
          ),
        ),
      ],
    );
  }

  /// Создаёт кнопку возврата на предыдущую страницу, и, если указано, заголовок страницы.
  Widget _titleBarWithBackButton(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          UIconButton(
            onPressed: () => Navigator.pop(context),
            iconData: Icons.arrow_back,
            iconSize: Device.isPhone(context) ? 24 : 27,
          ),
          const SizedBox(width: 8),
          if (widget.title != null)
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: Device.isPhone(context) ? 19 : 21,
                  fontWeight: Device.isPhone(context)
                      ? FontWeight.w500
                      : FontWeight.w700),
            ),
        ],
      ),
    );
  }
}

class CustomScrollController extends ScrollController {
  CustomScrollController({
    double initialScrollOffset = 0.0,
    keepScrollOffset = true,
    debugLabel,
  }) : super(
            initialScrollOffset: initialScrollOffset,
            keepScrollOffset: keepScrollOffset,
            debugLabel: debugLabel);

  @override
  _SilentScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition oldPosition,
  ) {
    return _SilentScrollPosition(
      physics: physics,
      context: context,
      oldPosition: oldPosition,
      initialPixels: initialScrollOffset,
    );
  }

  void jumpToWithoutGoingIdleAndKeepingBallistic(double value) {
    assert(positions.isNotEmpty, 'ScrollController not attached.');
    for (_SilentScrollPosition position in List<ScrollPosition>.from(positions))
      position.jumpToWithoutGoingIdleAndKeepingBallistic(value);
  }
}

class _SilentScrollPosition extends ScrollPositionWithSingleContext {
  _SilentScrollPosition({
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition oldPosition,
    double initialPixels,
  }) : super(
          physics: physics,
          context: context,
          oldPosition: oldPosition,
          initialPixels: initialPixels,
        );

  void jumpToWithoutGoingIdleAndKeepingBallistic(double value) {
    if (pixels != value) {
      forcePixels(value);
    }
  }
}
