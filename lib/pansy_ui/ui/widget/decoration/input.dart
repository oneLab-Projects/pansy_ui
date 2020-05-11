import 'package:flutter/material.dart';

/// Декоратор для [TextField] прямугольной формы.
class InputDesign extends InputDecoration {
  InputDesign(
    BuildContext context, {
    String hintText,
  }) : super(
          hintText: hintText,
          labelStyle: Theme.of(context).textTheme.subtitle1.copyWith(
              height: 1.4, color: Theme.of(context).textTheme.caption.color),
          prefixStyle: Theme.of(context).textTheme.subtitle1.copyWith(
              height: 1.4, color: Theme.of(context).textTheme.caption.color),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).cursorColor.withAlpha(20),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).cursorColor.withAlpha(20),
            ),
          ),
        );
}

/// Декоратор для [TextField] скругленной формы.
class RoundInputDesign extends InputDecoration {
  RoundInputDesign(
    BuildContext context, {
    String hintText,
  }) : super(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 18),
          filled: true,
          hintStyle: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: 17,
                color: Theme.of(context).textTheme.caption.color,
              ),
          fillColor: Theme.of(context).cardColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(style: BorderStyle.none),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).hintColor,
            ),
          ),
        );
}
