import 'package:intl/intl.dart';

extension IndianNumberFormatter on num {
  String toIndianFormat() {
    final formatter = NumberFormat("#,##,##,###", "en_IN");

    if (this % 1 == 0) {
      return formatter.format(toInt());
    }

    return this.toString();
  }
}
