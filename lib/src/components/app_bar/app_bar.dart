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
    var showBackButton = Navigator.of(context).canPop();

    var title = this.title != null
        ? DefaultTextStyle(
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            child: this.title,
          )
        : Container();

    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        SizedBox(
          height: APPBAR_HEIGHT,
          child: Row(
            children: [
              if (showBackButton)
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              if (!showBackButton) SizedBox(width: APPBAR_PADDING),
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
