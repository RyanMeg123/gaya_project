import 'package:flutter/material.dart';

class HexColor extends Color {
  // 构造函数，接收16进制颜色代码字符串
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  // 将16进制字符串转换为整数值的函数
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // 默认不透明
    }
    return int.parse(hexColor, radix: 16);
  }
}
