import 'package:pansy_ui/pansy_ui.dart';

import 'package:flutter/material.dart' as md;

class Scaffold extends StatefulWidget {
  final AppBar appBar;
  final Widget body;
  final Widget floatingActionButton;
  final Widget bottomNavigationBar;

  Scaffold({
    Key key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  _ScaffoldState createState() => _ScaffoldState();
}

class _ScaffoldState extends State<Scaffold> {
  @override
  Widget build(BuildContext context) {
    return md.Scaffold(
      body: Column(
        children: [
          if (widget.appBar != null) widget.appBar,
          if (widget.body != null)
            Expanded(
                child: Stack(
              children: <Widget>[
                widget.body,
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.all(20),
                  child: widget.floatingActionButton,
                ),
              ],
            )),
          if (widget.bottomNavigationBar != null) widget.bottomNavigationBar,
        ],
      ),
    );
  }
}
