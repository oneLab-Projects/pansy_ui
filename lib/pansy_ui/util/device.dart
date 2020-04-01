import 'dart:ui' as ui;

class Device {
  static double devicePixelRatio = ui.window.devicePixelRatio;
  static ui.Size size = ui.window.physicalSize;
  static double width = size.width;
  static double height = size.height;
  static double screenWidth = width / devicePixelRatio;
  static double screenHeight = height / devicePixelRatio;
  static ui.Size screenSize = ui.Size(screenWidth, screenHeight);

  static bool get isPhone {
    bool phone;

    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000))
      phone = false;
    else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920))
      phone = false;
    else
      phone = true;

    return phone;
  }
}
