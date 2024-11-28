import 'package:flutter/material.dart';

class FigmaPixelConverter {
  static double designWidth = 375.0; // Figma设计的宽度
  static double designHeight = 812.0; // Figma设计的高度

  static double widthScale(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    print("screenSize $screenSize");
    return screenSize.width / designWidth;
  }

  static double heightScale(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    print("screenSize $screenSize");
    return screenSize.height / designHeight;
  }

  static double getFigmaWidth(BuildContext context, double figmaWidth) {
    return figmaWidth * widthScale(context);
  }

  static double getFigmaHeight(BuildContext context, double figmaHeight) {
    return figmaHeight * heightScale(context);
  }
}
