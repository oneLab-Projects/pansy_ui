import 'dart:ui';

extension StringToLocale on String {
  Locale toLocale() {
    var localeTags = RegExp(r'^([a-z]{2})((-|_)([A-Z]{2}))?$');
    var match = localeTags.firstMatch(this);
    return Locale(match.group(1), match.group(4));
  }
}
