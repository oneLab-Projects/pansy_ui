import 'package:flutter/cupertino.dart';

class Device {
  static bool isPhone(BuildContext context) {
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000))
      return false;
    else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920))
      return false;
    else
      return true;
  }
}
