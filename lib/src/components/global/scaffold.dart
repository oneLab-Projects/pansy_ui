import 'package:pansy_ui/pansy_ui.dart';

import 'package:flutter/material.dart' as md;

class Scaffold extends StatefulWidget {
  final AppBar appBar;
  final Widget body;
  final Widget floatingActionButton;
  final Widget bottomNavigationBar;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool extendBodyBehindStatusBar;

  Scaffold({
    Key key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.extendBodyBehindStatusBar = false,
  }) : super(key: key);

  @override
  _ScaffoldState createState() => _ScaffoldState();
}

class _ScaffoldState extends State<Scaffold> {
  @override
  Widget build(BuildContext context) {
    return md.Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              if (!widget.extendBodyBehindStatusBar)
                SizedBox(height: MediaQuery.of(context).padding.top),
              if (widget.appBar != null && !widget.extendBodyBehindAppBar)
                SizedBox(
                  height: APPBAR_HEIGHT,
                ),
              if (widget.body != null) Expanded(child: widget.body),
              if (widget.bottomNavigationBar != null && !widget.extendBody)
                SizedBox(
                  height: APPBAR_HEIGHT,
                ),
            ],
          ),
          Column(
            children: [
              if (widget.appBar != null) widget.appBar,
              if (widget.body != null)
                Expanded(
                    child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.all(20),
                      child: widget.floatingActionButton,
                    ),
                  ],
                )),
              if (widget.bottomNavigationBar != null)
                widget.bottomNavigationBar,
            ],
          ),
        ],
      ),
    );
  }
}
