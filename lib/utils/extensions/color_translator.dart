import 'package:flutter/material.dart';

extension HexColor on String {
  Color toColor() {
    final hex = replaceAll('#', '').toUpperCase();

    final fullHex = hex.length == 6 ? 'FF$hex' : hex;

    return Color(int.parse(fullHex, radix: 16));
  }
}
