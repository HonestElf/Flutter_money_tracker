import 'package:flutter/widgets.dart';

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }

  if (hexColor.length == 8) {
    return Color(int.parse('0x$hexColor'));
  }

  throw FlutterError('Wrong color code');
}
