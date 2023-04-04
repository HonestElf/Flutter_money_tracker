// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Color getColorFromHex(String? hexColor) {
  if (hexColor != null && hexColor != '') {
    try {
      hexColor = hexColor.replaceAll('#', '');
      if (hexColor.length == 6) {
        hexColor = 'FF$hexColor';
      }

      if (hexColor.length == 8) {
        return Color(int.parse('0x$hexColor'));
      }
    } catch (error) {
      print("COLOR ERROR: ${error.toString()}");
      return const Color(0xFFFFFFFF);
    }
  }

  return const Color(0xFFFFFFFF);
  // throw FlutterError('Wrong color code');
}
