import 'package:intl/intl.dart';

extension DateFormatting on Object {
  String formatDate() {
    DateTime dateTime;

    if (this is String) {
      try {
        dateTime = DateTime.parse(this as String);
      } catch (e) {
        return ''; // Return empty string or fallback value
      }
    } else if (this is DateTime) {
      dateTime = this as DateTime;
    } else {
      throw ArgumentError('Invalid argument type: Expected String or DateTime');
    }

    return DateFormat('d MMM, yyyy').format(dateTime);
  }
}
