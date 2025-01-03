import 'dart:math';
import 'package:flutter/material.dart';

extension RandomColorString on String {
  static String generateRandomColorString() {
    final random = Random();
    final colorValue =
        (random.nextInt(0xFFFFFF + 1)).toRadixString(16).padLeft(6, '0');
    return 'ff$colorValue';
  }

  static Color toColor(String hexColor) {
    return Color(int.parse(hexColor, radix: 16));
  }
}
