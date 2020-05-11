import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui;

class Device {
  static bool isPhone(BuildContext context) {
    double devicePixelRatio, width, height;
    if (kIsWeb) {
      devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
    } else {
      devicePixelRatio = ui.window.devicePixelRatio;
      var size = ui.window.physicalSize;
      width = size.width;
      height = size.height;
    }

    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      return false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      return false;
    } else {
      return true;
    }
  }
}
