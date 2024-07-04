import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenHeight;
  static late double screenWidth;

  static late double heightMultiplier;
  static late double widthMultiplier;

  static void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    screenHeight = mediaQuery.size.height;
    screenWidth = mediaQuery.size.width;

    // Portrait Mode
    if (mediaQuery.orientation == Orientation.portrait) {
      heightMultiplier = screenHeight / 872.72;
      widthMultiplier = screenWidth / 392.72;
    }
    // Landscape Mode
    else {
      heightMultiplier = screenHeight / 392.72;
      widthMultiplier = screenWidth / 872.72;
    }
  }

  static double getHeight(double height) {
    return height * heightMultiplier;
  }

  static double getWidth(double width) {
    return width * widthMultiplier;
  }

  static double getFontSize(double fontSize) {
    return fontSize * heightMultiplier;
  }

  static double getIconSize(double iconSize) {
    return iconSize * heightMultiplier;
  }

  static double getRadius(double radius) {
    return radius * heightMultiplier;
  }

  static int getMaxLines(double containerHeight, double lineHeight) {
    int maxLines = (containerHeight / lineHeight).floor();
    return maxLines > 2 ? maxLines : 10;
  }
}
