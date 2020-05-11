import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Отображает диалог выбора.
/// ```dart
/// showSelectionDialog(
///   context,
///   actions: ['one', 'two', 'three'],
/// ).then(
///   (value) => print("$value tapped!"),
/// )
/// ```
Future<void> showScaffoldSheet(BuildContext context, {Widget child}) {
  return showCupertinoModalPopup<void>(
      context: context, builder: (BuildContext context) => child).then((v) {});
}

/// Диалог выбора. Вызывается методом `showSelectionDialog`
class ScaffoldSheet extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  ScaffoldSheet({
    Key key,
    this.title,
    this.description,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20).copyWith(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (title != null) _buildTitle(context),
              if (description != null) _buildDescription(context),
              if (title != null || description != null)
                const SizedBox(height: 23),
              child,
            ],
          ),
        ));
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .subtitle2
            .copyWith(color: Theme.of(context).hintColor),
      ),
    );
  }
}
