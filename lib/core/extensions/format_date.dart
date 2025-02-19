import 'package:intl/intl.dart';

extension DateFormatting on dynamic {
  String formatDate() {
    DateTime dateTime;

    if (this is String) {
      try {
        dateTime = DateTime.parse(this as String);
      } catch (e) {
        dateTime = DateTime.now();
      }
    } else if (this is DateTime) {
      dateTime = this as DateTime;
    } else {
      throw ArgumentError('Invalid argument type');
    }

    return DateFormat('d MMM, yyyy').format(dateTime);
  }
}
