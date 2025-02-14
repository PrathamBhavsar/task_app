import 'package:intl/intl.dart';

class IndianNumberHelper {
  static String format(double value) {
    final formatter = NumberFormat("#,##,##,###", "en_IN");

    if (value % 1 == 0) {
      return formatter.format(value.toInt());
    }

    return value.toString();
  }
}
