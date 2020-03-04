import 'dart:ui';

extension StringToLocale on String {
  Locale get toLocale {
    RegExp localeTags = RegExp(r'^([a-z]{2})((-|_)([A-Z]{2}))?$');
    RegExpMatch match = localeTags.firstMatch(this);
    return Locale(match.group(1), match.group(4));
  }
}
