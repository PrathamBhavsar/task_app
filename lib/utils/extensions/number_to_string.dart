extension NumberFormatting on num {
  String formatNumber() => this % 1 == 0 ? toInt().toString() : toString();
}
