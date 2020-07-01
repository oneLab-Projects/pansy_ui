import 'package:pansy_ui/pansy_ui.dart';

const double APPBAR_HEIGHT = 55;
const double APPBAR_PADDING = 16;

class AppBar extends StatelessWidget {
  final Widget title;
  final List<Widget> actions;

  AppBar({
    Key key,
    this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title = DefaultTextStyle(
      style: Theme.of(context).textTheme.headline6.copyWith(
            fontWeight: FontWeight.bold,
          ),
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: this.title,
    );

    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        SizedBox(
          height: APPBAR_HEIGHT,
          child: Row(
            children: [
              SizedBox(width: APPBAR_PADDING),
              Expanded(child: title),
              if (actions != null) Row(children: actions),
              SizedBox(width: APPBAR_PADDING - 10),
            ],
          ),
        ),
      ],
    );
  }
}
