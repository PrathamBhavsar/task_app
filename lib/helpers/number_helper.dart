class NumberHelper {
  static String format(double value) =>
      value % 1 == 0 ? value.toInt().toString() : value.toString();
}
